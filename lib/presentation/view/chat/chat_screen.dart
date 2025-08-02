// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kitetech_student_portal/data/client/api_client.dart';
// import 'package:kitetech_student_portal/data/respository/student_repository.dart';
// import 'package:kitetech_student_portal/presentation/bloc/chat/chat_bloc.dart';

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ChatBloc(
//         repository: StudentRepository(ApiClient()),
//       ),
//       child: const ChatView(),
//     );
//   }
// }

// class ChatView extends StatefulWidget {
//   const ChatView({super.key});

//   @override
//   State<ChatView> createState() => _ChatViewState();
// }

// class _ChatViewState extends State<ChatView> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//   final TextEditingController _searchController = TextEditingController();
//   final TextEditingController _roomIdController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _usernameController.text = '52100973';
//     _passwordController.text = 'password123';
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     _messageController.dispose();
//     _searchController.dispose();
//     _roomIdController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat System'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Connection Status
//             _buildStatusCard(),
//             const SizedBox(height: 16),

//             // User Management Section
//             _buildUserManagementSection(),
//             const SizedBox(height: 16),

//             // User Operations Section
//             _buildUserOperationsSection(),
//             const SizedBox(height: 16),

//             // Message Operations Section
//             _buildMessageOperationsSection(),
//             const SizedBox(height: 16),

//             // Room Operations Section
//             _buildRoomOperationsSection(),
//             const SizedBox(height: 16),

//             // Results Section
//             _buildResultsSection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusCard() {
//     return Card(
//       color: Colors.blue.shade50,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Text(
//               'Connection Status',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             BlocBuilder<ChatBloc, ChatState>(
//               builder: (context, state) {
//                 final chatBloc = context.read<ChatBloc>();
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       chatBloc.isConnected ? Icons.wifi : Icons.wifi_off,
//                       color: chatBloc.isConnected ? Colors.green : Colors.red,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       chatBloc.isConnected ? 'Connected' : 'Disconnected',
//                       style: TextStyle(
//                         color: chatBloc.isConnected ? Colors.green : Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUserManagementSection() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'User Management',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 labelText: 'Username',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatBloc>().add(
//                             ChatLoginUser(
//                               username: _usernameController.text,
//                               password: _passwordController.text,
//                             ),
//                           );
//                     },
//                     child: const Text('Login'),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatBloc>().add(
//                             ChatConnectUser(
//                               username: _usernameController.text,
//                             ),
//                           );
//                     },
//                     child: const Text('Connect'),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatBloc>().add(
//                             ChatDisconnectUser(
//                               username: _usernameController.text,
//                             ),
//                           );
//                     },
//                     child: const Text('Disconnect'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUserOperationsSection() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'User Operations',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatBloc>().add(GetOnlineUsers());
//                     },
//                     child: const Text('Get Online Users'),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatBloc>().add(GetAllUsers());
//                     },
//                     child: const Text('Get All Users'),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _searchController,
//                     decoration: const InputDecoration(
//                       labelText: 'Search Username',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<ChatBloc>().add(
//                           SearchUsers(username: _searchController.text),
//                         );
//                   },
//                   child: const Text('Search'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageOperationsSection() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Message Operations',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _roomIdController,
//                     decoration: const InputDecoration(
//                       labelText: 'Room ID',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<ChatBloc>().add(
//                           GetMessagesByRoomId(roomId: _roomIdController.text),
//                         );
//                   },
//                   child: const Text('Get Messages'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: const InputDecoration(
//                       labelText: 'Message',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {
//                     context.read<ChatBloc>().add(
//                           SendMessage(
//                             content: _messageController.text,
//                             roomId: _roomIdController.text,
//                           ),
//                         );
//                     _messageController.clear();
//                   },
//                   child: const Text('Send'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRoomOperationsSection() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Room Operations',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatBloc>().add(
//                             FindChatRoomByMembers(
//                               members: ['user1', 'user2'],
//                             ),
//                           );
//                     },
//                     child: const Text('Find Room'),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatBloc>().add(
//                             CreateChatRoom(
//                               members: ['user1', 'user2'],
//                               userName: _usernameController.text,
//                             ),
//                           );
//                     },
//                     child: const Text('Create Room'),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatBloc>().add(
//                             FindMessageRoomById(roomId: _roomIdController.text),
//                           );
//                     },
//                     child: const Text('Find Room by ID'),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       context.read<ChatBloc>().add(
//                             UpdateLastSeen(
//                               roomId: _roomIdController.text,
//                               memberId: _usernameController.text,
//                             ),
//                           );
//                     },
//                     child: const Text('Update Last Seen'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildResultsSection() {
//     return BlocBuilder<ChatBloc, ChatState>(
//       builder: (context, state) {
//         if (state is ChatLoading) {
//           return const Card(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         }

//         if (state is ChatError) {
//           return Card(
//             color: Colors.red.shade50,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Error',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(state.message),
//                 ],
//               ),
//             ),
//           );
//         }

//         if (state is OnlineUsersLoaded) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Online Users',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...state.users.map((user) => ListTile(
//                         leading: const CircleAvatar(
//                           child: Icon(Icons.person),
//                         ),
//                         title: Text(user['username'] ?? 'Unknown'),
//                         subtitle: Text(user['status'] ?? ''),
//                         trailing: const Icon(
//                           Icons.circle,
//                           color: Colors.green,
//                           size: 12,
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//           );
//         }

//         if (state is AllUsersLoaded) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'All Users',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...state.users.map((user) => ListTile(
//                         leading: const CircleAvatar(
//                           child: Icon(Icons.person),
//                         ),
//                         title: Text(user['username'] ?? 'Unknown'),
//                         subtitle: Text(user['status'] ?? ''),
//                       )),
//                 ],
//               ),
//             ),
//           );
//         }

//         if (state is UsersFound) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Search Results',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...state.users.map((user) => ListTile(
//                         leading: const CircleAvatar(
//                           child: Icon(Icons.person),
//                         ),
//                         title: Text(user['username'] ?? 'Unknown'),
//                         subtitle: Text(user['status'] ?? ''),
//                       )),
//                 ],
//               ),
//             ),
//           );
//         }

//         if (state is MessagesLoaded) {
//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Messages',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ...state.messages.map((message) => ListTile(
//                         leading: const CircleAvatar(
//                           child: Icon(Icons.message),
//                         ),
//                         title: Text(message['content'] ?? ''),
//                         subtitle: Text(message['dateSent'] ?? ''),
//                       )),
//                 ],
//               ),
//             ),
//           );
//         }

//         if (state is ChatRoomFound ||
//             state is ChatRoomCreated ||
//             state is MessageRoomFound) {
//           final room = state is ChatRoomFound
//               ? (state as ChatRoomFound).room
//               : state is ChatRoomCreated
//                   ? (state as ChatRoomCreated).room
//                   : (state as MessageRoomFound).room;

//           return Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     state is ChatRoomFound
//                         ? 'Room Found'
//                         : state is ChatRoomCreated
//                             ? 'Room Created'
//                             : 'Room Details',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ListTile(
//                     leading: const CircleAvatar(
//                       child: Icon(Icons.chat),
//                     ),
//                     title: Text(room['name'] ?? 'Unknown Room'),
//                     subtitle: Text('ID: ${room['id'] ?? 'N/A'}'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
