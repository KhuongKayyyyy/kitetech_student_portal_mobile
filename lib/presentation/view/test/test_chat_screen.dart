// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kitetech_student_portal/data/client/api_client.dart';
// import 'package:kitetech_student_portal/data/respository/student_repository.dart';
// import 'package:kitetech_student_portal/presentation/bloc/chat/chat_bloc.dart';
// import 'package:kitetech_student_portal/presentation/bloc/authentication/authentication_bloc.dart';

// class TestChatScreen extends StatelessWidget {
//   const TestChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ChatBloc(
//         repository: StudentRepository(ApiClient()),
//       ),
//       child: const TestChatView(),
//     );
//   }
// }

// class TestChatView extends StatefulWidget {
//   const TestChatView({super.key});

//   @override
//   State<TestChatView> createState() => _TestChatViewState();
// }

// class _TestChatViewState extends State<TestChatView> {
//   final TextEditingController _messageController = TextEditingController();
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test Chat API'),
//         backgroundColor: Colors.orange,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Status Card
//             Card(
//               color: Colors.blue.shade50,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Connection Status',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     BlocBuilder<ChatBloc, ChatState>(
//                       builder: (context, state) {
//                         final chatBloc = context.read<ChatBloc>();
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               chatBloc.isConnected
//                                   ? Icons.wifi
//                                   : Icons.wifi_off,
//                               color: chatBloc.isConnected
//                                   ? Colors.green
//                                   : Colors.red,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               chatBloc.isConnected
//                                   ? 'Connected'
//                                   : 'Disconnected',
//                               style: TextStyle(
//                                 color: chatBloc.isConnected
//                                     ? Colors.green
//                                     : Colors.red,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Connect to Chat Section
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       '1. Connect to Chat',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       'This will connect you to the chat system using your authenticated user account.',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     const SizedBox(height: 16),
//                     BlocBuilder<AuthenticationBloc, AuthenticationState>(
//                       builder: (context, authState) {
//                         if (authState is AuthenticationStateLoggedIn) {
//                           return Column(
//                             children: [
//                               Text(
//                                   'Logged in as: ${authState.appUser.username}'),
//                               const SizedBox(height: 16),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     context.read<ChatBloc>().add(
//                                           ChatConnectUser(
//                                             username:
//                                                 authState.appUser.username,
//                                           ),
//                                         );
//                                   },
//                                   child: const Text('Connect to Chat'),
//                                 ),
//                               ),
//                             ],
//                           );
//                         } else {
//                           return const Text(
//                             'Please log in first to use chat functionality',
//                             style: TextStyle(color: Colors.red),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Online Users Section
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           '2. Get Online Users',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             context.read<ChatBloc>().add(GetOnlineUsers());
//                           },
//                           child: const Text('Refresh'),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     BlocBuilder<ChatBloc, ChatState>(
//                       builder: (context, state) {
//                         if (state is OnlineUsersLoaded) {
//                           return Column(
//                             children: state.users.map((user) {
//                               return ListTile(
//                                 leading: const CircleAvatar(
//                                   child: Icon(Icons.person),
//                                 ),
//                                 title: Text(user['username'] ?? 'Unknown'),
//                                 subtitle: Text(user['fullName'] ?? ''),
//                                 trailing: const Icon(
//                                   Icons.circle,
//                                   color: Colors.green,
//                                   size: 12,
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         } else if (state is ChatLoading) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }
//                         return const Center(
//                           child: Text('No online users'),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Search Users Section
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       '3. Search Users',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _searchController,
//                             decoration: const InputDecoration(
//                               labelText: 'Search by username',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () {
//                             context.read<ChatBloc>().add(
//                                   SearchUsers(
//                                     username: _searchController.text,
//                                   ),
//                                 );
//                           },
//                           child: const Text('Search'),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     BlocBuilder<ChatBloc, ChatState>(
//                       builder: (context, state) {
//                         if (state is UsersFound) {
//                           return Column(
//                             children: state.users.map((user) {
//                               return ListTile(
//                                 leading: const CircleAvatar(
//                                   child: Icon(Icons.person),
//                                 ),
//                                 title: Text(user['username'] ?? 'Unknown'),
//                                 subtitle: Text(user['fullName'] ?? ''),
//                                 trailing: ElevatedButton(
//                                   onPressed: () {
//                                     _showChatDialog(context, user['username']);
//                                   },
//                                   child: const Text('Chat'),
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         }
//                         return const SizedBox.shrink();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Error Display
//             BlocBuilder<ChatBloc, ChatState>(
//               builder: (context, state) {
//                 if (state is ChatError) {
//                   return Card(
//                     color: Colors.red.shade50,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Error',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(state.message),
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showChatDialog(BuildContext context, String username) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Chat with $username'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _messageController,
//               decoration: const InputDecoration(
//                 labelText: 'Message',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               context.read<ChatBloc>().add(
//                     SendMessage(
//                       content: _messageController.text,
//                       roomId:
//                           'room_id', // You might want to get this from a parameter
//                     ),
//                   );
//               _messageController.clear();
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Message sent to $username'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             },
//             child: const Text('Send'),
//           ),
//         ],
//       ),
//     );
//   }
// }
