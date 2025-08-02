// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kitetech_student_portal/data/respository/student_repository.dart';
// import 'package:kitetech_student_portal/data/service/chat_service.dart';
// import 'package:kitetech_student_portal/core/network/api.dart';
// import 'package:kitetech_student_portal/data/model/chat_user.dart';
// import 'package:kitetech_student_portal/data/model/message_content.dart';
// import 'package:kitetech_student_portal/data/model/message_room.dart';

// // Events
// abstract class ChatEvent {}

// // User Management Events
// class ChatLoginUser extends ChatEvent {
//   final String username;
//   final String password;
//   ChatLoginUser({required this.username, required this.password});
// }

// class ChatConnectUser extends ChatEvent {
//   final String username;
//   ChatConnectUser({required this.username});
// }

// class ChatDisconnectUser extends ChatEvent {
//   final String username;
//   ChatDisconnectUser({required this.username});
// }

// class GetOnlineUsers extends ChatEvent {}

// class GetAllUsers extends ChatEvent {}

// class SearchUsers extends ChatEvent {
//   final String username;
//   SearchUsers({required this.username});
// }

// // Message Events
// class SendMessage extends ChatEvent {
//   final String content;
//   final String roomId;
//   final String messageType;
//   SendMessage(
//       {required this.content, required this.roomId, this.messageType = 'TEXT'});
// }

// class GetMessagesByRoomId extends ChatEvent {
//   final String roomId;
//   GetMessagesByRoomId({required this.roomId});
// }

// // Room Management Events
// class FindChatRoomByMembers extends ChatEvent {
//   final List<String> members;
//   FindChatRoomByMembers({required this.members});
// }

// class CreateChatRoom extends ChatEvent {
//   final List<String> members;
//   final String userName;
//   CreateChatRoom({required this.members, required this.userName});
// }

// class FindChatRoomsWithContent extends ChatEvent {
//   final String username;
//   final String roomId;
//   FindChatRoomsWithContent({required this.username, required this.roomId});
// }

// class FindMessageRoomById extends ChatEvent {
//   final String roomId;
//   FindMessageRoomById({required this.roomId});
// }

// // Member Management Events
// class UpdateLastSeen extends ChatEvent {
//   final String roomId;
//   final String memberId;
//   UpdateLastSeen({required this.roomId, required this.memberId});
// }

// // States
// abstract class ChatState {}

// class ChatInitial extends ChatState {}

// class ChatLoading extends ChatState {}

// // User States
// class ChatUserLoggedIn extends ChatState {
//   final Map<String, dynamic> userData;
//   ChatUserLoggedIn({required this.userData});
// }

// class ChatUserConnected extends ChatState {
//   final String username;
//   ChatUserConnected({required this.username});
// }

// class ChatUserDisconnected extends ChatState {
//   final String username;
//   ChatUserDisconnected({required this.username});
// }

// class OnlineUsersLoaded extends ChatState {
//   final List<Map<String, dynamic>> users;
//   OnlineUsersLoaded({required this.users});
// }

// class AllUsersLoaded extends ChatState {
//   final List<Map<String, dynamic>> users;
//   AllUsersLoaded({required this.users});
// }

// class UsersFound extends ChatState {
//   final List<Map<String, dynamic>> users;
//   UsersFound({required this.users});
// }

// // Message States
// class MessageSent extends ChatState {
//   final String content;
//   final String roomId;
//   MessageSent({required this.content, required this.roomId});
// }

// class MessagesLoaded extends ChatState {
//   final List<Map<String, dynamic>> messages;
//   MessagesLoaded({required this.messages});
// }

// // Room States
// class ChatRoomFound extends ChatState {
//   final Map<String, dynamic> room;
//   ChatRoomFound({required this.room});
// }

// class ChatRoomCreated extends ChatState {
//   final Map<String, dynamic> room;
//   ChatRoomCreated({required this.room});
// }

// class ChatRoomsWithContentLoaded extends ChatState {
//   final List<Map<String, dynamic>> rooms;
//   ChatRoomsWithContentLoaded({required this.rooms});
// }

// class MessageRoomFound extends ChatState {
//   final Map<String, dynamic> room;
//   MessageRoomFound({required this.room});
// }

// // Member States
// class LastSeenUpdated extends ChatState {
//   final String roomId;
//   final String memberId;
//   LastSeenUpdated({required this.roomId, required this.memberId});
// }

// class ChatError extends ChatState {
//   final String message;
//   ChatError({required this.message});
// }

// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final StudentRepository _repository;
//   final ChatService _chatService;

//   ChatBloc({required StudentRepository repository})
//       : _repository = repository,
//         _chatService = ChatService(),
//         super(ChatInitial()) {
//     // Set up WebSocket callbacks
//     _chatService.onUserConnected = (user) {
//       print('User connected: ${user.username}');
//     };

//     _chatService.onUserDisconnected = (user) {
//       print('User disconnected: ${user.username}');
//     };

//     _chatService.onMessageReceived = (message) {
//       print('Received message: ${message.content} from ${message.userId}');
//     };

//     _chatService.onRoomCreated = (room) {
//       print('Room created: ${room.name}');
//     };

//     _chatService.onRoomUpdated = (room) {
//       print('Room updated: ${room.name}');
//     };

//     _chatService.onError = (error) {
//       add(_ErrorEvent(message: error));
//     };

//     // Event handlers
//     on<ChatLoginUser>(_onChatLoginUser);
//     on<ChatConnectUser>(_onChatConnectUser);
//     on<ChatDisconnectUser>(_onChatDisconnectUser);
//     on<GetOnlineUsers>(_onGetOnlineUsers);
//     on<GetAllUsers>(_onGetAllUsers);
//     on<SearchUsers>(_onSearchUsers);
//     on<SendMessage>(_onSendMessage);
//     on<GetMessagesByRoomId>(_onGetMessagesByRoomId);
//     on<FindChatRoomByMembers>(_onFindChatRoomByMembers);
//     on<CreateChatRoom>(_onCreateChatRoom);
//     on<FindChatRoomsWithContent>(_onFindChatRoomsWithContent);
//     on<FindMessageRoomById>(_onFindMessageRoomById);
//     on<UpdateLastSeen>(_onUpdateLastSeen);
//     on<_ErrorEvent>(_onError);
//   }

//   // User Management Handlers
//   Future<void> _onChatLoginUser(
//       ChatLoginUser event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       final result =
//           await _repository.loginChatUser(event.username, event.password);

//       if (result.isNotEmpty) {
//         emit(ChatUserLoggedIn(userData: result));
//       } else {
//         emit(ChatError(message: 'Login failed'));
//       }
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   Future<void> _onChatConnectUser(
//       ChatConnectUser event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       await _chatService.connect(APIRoute.javaBaseUrl, event.username);
//       emit(ChatUserConnected(username: event.username));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   Future<void> _onChatDisconnectUser(
//       ChatDisconnectUser event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       await _chatService.disconnect();
//       emit(ChatUserDisconnected(username: event.username));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   Future<void> _onGetOnlineUsers(
//       GetOnlineUsers event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       final users = await _repository.getOnlineUsers();
//       emit(OnlineUsersLoaded(users: users));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   Future<void> _onGetAllUsers(
//       GetAllUsers event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       final users = await _repository.getAllUsers();
//       emit(AllUsersLoaded(users: users));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   Future<void> _onSearchUsers(
//       SearchUsers event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       final users = await _repository.searchUsersByUsername(event.username);
//       emit(UsersFound(users: users));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   // Message Handlers
//   Future<void> _onSendMessage(
//       SendMessage event, Emitter<ChatState> emit) async {
//     try {
//       await _chatService.sendMessage(event.content, '', roomId: event.roomId);
//       emit(MessageSent(content: event.content, roomId: event.roomId));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   Future<void> _onGetMessagesByRoomId(
//       GetMessagesByRoomId event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       final messages = await _repository.getMessagesByRoomId(event.roomId);
//       emit(MessagesLoaded(messages: messages));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   // Room Management Handlers
//   Future<void> _onFindChatRoomByMembers(
//       FindChatRoomByMembers event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       final room = await _repository.findChatRoomByMembers(event.members);
//       emit(ChatRoomFound(room: room));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   Future<void> _onCreateChatRoom(
//       CreateChatRoom event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       final room =
//           await _repository.createChatRoom(event.members, event.userName);
//       emit(ChatRoomCreated(room: room));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   Future<void> _onFindChatRoomsWithContent(
//       FindChatRoomsWithContent event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       final rooms = await _repository.findChatRoomsWithContent(
//           event.username, event.roomId);
//       emit(ChatRoomsWithContentLoaded(rooms: rooms));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   Future<void> _onFindMessageRoomById(
//       FindMessageRoomById event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       final room = await _repository.findMessageRoomById(event.roomId);
//       emit(MessageRoomFound(room: room));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   // Member Management Handlers
//   Future<void> _onUpdateLastSeen(
//       UpdateLastSeen event, Emitter<ChatState> emit) async {
//     try {
//       emit(ChatLoading());

//       await _repository.updateLastSeen(event.roomId, event.memberId);
//       emit(LastSeenUpdated(roomId: event.roomId, memberId: event.memberId));
//     } catch (e) {
//       emit(ChatError(message: e.toString()));
//     }
//   }

//   void _onError(_ErrorEvent event, Emitter<ChatState> emit) {
//     emit(ChatError(message: event.message));
//   }

//   // Helper methods
//   bool get isConnected => _chatService.isConnected;
//   String? get currentUsername => _chatService.currentUsername;

//   void dispose() {
//     _chatService.disconnect();
//   }
// }

// // Helper event for errors
// class _ErrorEvent extends ChatEvent {
//   final String message;
//   _ErrorEvent({required this.message});
// }
