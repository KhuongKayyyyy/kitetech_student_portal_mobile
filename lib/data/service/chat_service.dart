import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:kitetech_student_portal/data/model/chat_user.dart';
import 'package:kitetech_student_portal/data/model/message_content.dart';
import 'package:kitetech_student_portal/data/model/message_room.dart';

class ChatService {
  WebSocketChannel? _channel;
  String? _username;

  // Callbacks for real-time updates
  Function(ChatUser)? onUserConnected;
  Function(ChatUser)? onUserDisconnected;
  Function(MessageContent)? onMessageReceived;
  Function(MessageRoom)? onRoomCreated;
  Function(MessageRoom)? onRoomUpdated;
  Function(String)? onError;

  // Connect to WebSocket
  Future<void> connect(String baseUrl, String username) async {
    try {
      _username = username;

      // Connect to WebSocket endpoint
      final wsUrl = baseUrl.replaceFirst('http', 'ws');
      final uri = Uri.parse('$wsUrl/ws');

      _channel = WebSocketChannel.connect(uri);

      // Listen for messages
      _channel!.stream.listen(
        (message) {
          _handleMessage(message);
        },
        onError: (error) {
          print('WebSocket error: $error');
          onError?.call(error.toString());
        },
        onDone: () {
          print('WebSocket connection closed');
        },
      );

      // Send connect message
      await _sendConnectMessage(username);
    } catch (e) {
      print('Error connecting to WebSocket: $e');
      onError?.call(e.toString());
    }
  }

  // Disconnect from WebSocket
  Future<void> disconnect() async {
    try {
      if (_channel != null && _username != null) {
        // Send disconnect message
        await _sendDisconnectMessage(_username!);

        // Close connection
        await _channel!.sink.close(status.goingAway);
        _channel = null;
        _username = null;
      }
    } catch (e) {
      print('Error disconnecting from WebSocket: $e');
      onError?.call(e.toString());
    }
  }

  // Send connect message
  Future<void> _sendConnectMessage(String username) async {
    if (_channel != null) {
      final message = {
        'type': 'connect',
        'username': username,
      };
      _channel!.sink.add(jsonEncode(message));
    }
  }

  // Send disconnect message
  Future<void> _sendDisconnectMessage(String username) async {
    if (_channel != null) {
      final message = {
        'type': 'disconnect',
        'username': username,
      };
      _channel!.sink.add(jsonEncode(message));
    }
  }

  // Send chat message
  Future<void> sendMessage(String message, String toUsername,
      {String? roomId}) async {
    if (_channel != null && _username != null) {
      final chatMessage = {
        'type': 'message',
        'from': _username,
        'to': toUsername,
        'content': message,
        'roomId': roomId,
        'timestamp': DateTime.now().toIso8601String(),
      };
      _channel!.sink.add(jsonEncode(chatMessage));
    }
  }

  // Create a new chat room
  Future<void> createRoom(String roomName, List<String> memberUsernames,
      {bool isGroup = false}) async {
    if (_channel != null && _username != null) {
      final roomMessage = {
        'type': 'create_room',
        'name': roomName,
        'isGroup': isGroup,
        'createdBy': _username,
        'members': memberUsernames,
        'timestamp': DateTime.now().toIso8601String(),
      };
      _channel!.sink.add(jsonEncode(roomMessage));
    }
  }

  // Join a chat room
  Future<void> joinRoom(String roomId) async {
    if (_channel != null && _username != null) {
      final joinMessage = {
        'type': 'join_room',
        'roomId': roomId,
        'username': _username,
        'timestamp': DateTime.now().toIso8601String(),
      };
      _channel!.sink.add(jsonEncode(joinMessage));
    }
  }

  // Leave a chat room
  Future<void> leaveRoom(String roomId) async {
    if (_channel != null && _username != null) {
      final leaveMessage = {
        'type': 'leave_room',
        'roomId': roomId,
        'username': _username,
        'timestamp': DateTime.now().toIso8601String(),
      };
      _channel!.sink.add(jsonEncode(leaveMessage));
    }
  }

  // Handle incoming messages
  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message.toString());
      final type = data['type'];

      switch (type) {
        case 'user_connected':
          final user = ChatUser.fromJson(data['user']);
          onUserConnected?.call(user);
          break;
        case 'user_disconnected':
          final user = ChatUser.fromJson(data['user']);
          onUserDisconnected?.call(user);
          break;
        case 'message':
          final messageContent = MessageContent.fromJson(data);
          onMessageReceived?.call(messageContent);
          break;
        case 'room_created':
          final room = MessageRoom.fromJson(data['room']);
          onRoomCreated?.call(room);
          break;
        case 'room_updated':
          final room = MessageRoom.fromJson(data['room']);
          onRoomUpdated?.call(room);
          break;
        default:
          print('Unknown message type: $type');
      }
    } catch (e) {
      print('Error handling message: $e');
    }
  }

  // Check if connected
  bool get isConnected => _channel != null;

  // Get current username
  String? get currentUsername => _username;
}
