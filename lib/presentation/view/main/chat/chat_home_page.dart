import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/network/api.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/data/model/app_user.dart';
import 'package:kitetech_student_portal/data/model/chat_user.dart';
import 'package:kitetech_student_portal/data/model/message_room.dart';
import 'package:kitetech_student_portal/data/model/student_card_data.dart';
import 'package:kitetech_student_portal/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:kitetech_student_portal/presentation/bloc/chat_user/chat_user_bloc.dart';
import 'package:kitetech_student_portal/presentation/bloc/message_room/message_room_bloc.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_room_item.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_search_bar.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/user_bubble.dart';
import 'package:http/http.dart' as http;
import 'package:kitetech_student_portal/presentation/widget/student/student_card.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  bool _showSearchBar = false;
  late FToast fToast;
  bool isAvailable = false;
  String? tagData;
  String? errorMessage;
  String? studentRFID;
  Map<String, dynamic>? studentInfo;
  StudentCardData? foundStudentCard;
  AppUser? currentUser;
  @override
  void initState() {
    super.initState();
    _checkNfcAvailability();
    fToast = FToast();
    fToast.init(context);
    context.read<ChatUserBloc>().add(ChatUserEventGetAllUsers());
    // Get current user from authentication state
    final authState = context.read<AuthenticationBloc>().state;
    if (authState is AuthenticationStateLoggedIn) {
      currentUser = authState.appUser;
    }

    context.read<MessageRoomBloc>().add(
        MessageRoomEventGetMessageRoomsByUserName(currentUser?.username ?? ''));
  }

  Future<void> _checkNfcAvailability() async {
    isAvailable = await NfcManager.instance.isAvailable();
    setState(() {
      isAvailable = isAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: AppTextStyle.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AppRouter.checkChatRequestPage);
            },
            icon: const Icon(Icons.group_add),
          ),
          IconButton(
            onPressed: () {
              _showAddUserDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
          // Test button for new chat functionality
          IconButton(
            onPressed: () {
              _showTestChatDialog(context);
            },
            icon: const Icon(Icons.science),
            tooltip: 'Test Chat API',
          ),
        ],
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationStateLoggedIn) {
            setState(() {
              currentUser = state.appUser;
            });
          }
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels <= 0 &&
                notification is ScrollUpdateNotification &&
                notification.scrollDelta != null &&
                notification.scrollDelta! < -10) {
              // User is pulling down at the top
              setState(() {
                _showSearchBar = true;
              });
            }
            return false;
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _showSearchBar ? 60 : 0,
                  child: _showSearchBar
                      ? Hero(
                          tag: "chat-search",
                          child: ChatSearchBar(
                            onTap: () => context.push(AppRouter.chatHomeSearch),
                          ))
                      : const SizedBox.shrink(),
                ),
                BlocBuilder<ChatUserBloc, ChatUserState>(
                  bloc: context.read<ChatUserBloc>(),
                  builder: (context, chatUserState) {
                    if (chatUserState is ChatUserStateAllUsers) {
                      // Only filter if currentUser is not null
                      final filteredUsers = currentUser != null
                          ? chatUserState.allUsers
                              .where((user) =>
                                  user.username != currentUser!.username)
                              .toList()
                          : chatUserState.allUsers;
                      return _buildUserList(users: filteredUsers);
                    } else if (chatUserState is ChatUserStateError) {
                      return Text(chatUserState.message);
                    } else if (chatUserState is ChatUserStateLoading) {
                      return Skeletonizer(
                        child: _buildUserList(users: FakeData.chatUsers),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const Divider(height: 1),
                BlocBuilder<MessageRoomBloc, MessageRoomState>(
                  bloc: context.read<MessageRoomBloc>(),
                  builder: (context, mrState) {
                    if (mrState is MessageRoomStateLoaded) {
                      return _buildChatRoomList(mrState.messageRooms);
                    } else if (mrState is MessageRoomStateError) {
                      return Text(mrState.message);
                    } else if (mrState is MessageRoomStateLoading) {
                      return Skeletonizer(
                        child: _buildChatRoomList(FakeData.messageRooms),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddUserDialog(BuildContext context) {
    final TextEditingController studentIdController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.person_add,
                  color: AppColors.primaryColor, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'Thêm người dùng',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nhập mã số sinh viên để thêm vào danh sách chat',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: studentIdController,
              decoration: InputDecoration(
                labelText: 'Mã số sinh viên',
                labelStyle: TextStyle(color: AppColors.primaryColor),
                hintText: 'Ví dụ: 52100973',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.badge,
                      color: AppColors.primaryColor, size: 20),
                ),
                suffixIcon: isAvailable
                    ? Container(
                        margin: const EdgeInsets.all(4),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              tagData = null;
                              errorMessage = null;
                              studentInfo = null;
                              foundStudentCard = null;
                            });
                            NfcManager.instance.startSession(
                              onDiscovered: (NfcTag tag) async {
                                final NfcA? nfca = NfcA.from(tag);
                                if (nfca == null) {
                                  NfcManager.instance.stopSession(
                                      errorMessage: 'Not an NFC-A tag');
                                  return;
                                }
                                Uint8List uidBytes = nfca.identifier;

                                String uidHex = uidBytes
                                    .map((b) =>
                                        b.toRadixString(16).padLeft(2, '0'))
                                    .join('')
                                    .toUpperCase();
                                await _fetchStudentInfo(uidHex);

                                setState(() {
                                  tagData = tag.data.toString();
                                  studentRFID = uidHex;
                                });

                                NfcManager.instance.stopSession();
                                // Pop the NFC reader dialog
                                // ignore: use_build_context_synchronously
                                context.pop();
                                // Show student card popup
                                if (foundStudentCard != null) {
                                  // ignore: use_build_context_synchronously
                                  _showStudentCardPopup(
                                      context, foundStudentCard!);
                                }
                              },
                              onError: (error) async {
                                setState(() {
                                  errorMessage = error.toString();
                                });
                                NfcManager.instance.stopSession(
                                    errorMessage: error.toString());
                              },
                            );
                            _showNFCReader(context);
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.nfc,
                                color: AppColors.primaryColor, size: 20),
                          ),
                          tooltip: 'Quét NFC để thêm người dùng',
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Hủy',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              if (studentIdController.text.trim().isNotEmpty) {
                // Handle add user logic here
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              elevation: 2,
              shadowColor: AppColors.primaryColor.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Thêm',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchStudentInfo(String rfid) async {
    try {
      final response = await http.post(
        Uri.parse('${APIRoute.baseUrlTest}/api/student'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'rfid': rfid}),
      );

      if (response.statusCode == 200) {
        setState(() {
          studentInfo = json.decode(response.body);
          if (kDebugMode) {
            print('Student Info: $studentInfo');
          }
          foundStudentCard = StudentCardData(
            studentName: "Nguyen Dat Khuong",
            studentId: "52100973",
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXXckRlC33zt7zHBLpEEEeqY_MGIn89LOdGw&s",
            classId: "52100973",
            major: "CNTT",
            department: "CNTT",
            birthDate: "2002-01-01",
            gender: "Male",
            address: "123 Main St",
          );
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch student information';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  Future<dynamic> _showNFCReader(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.nfc, color: AppColors.primaryColor),
              SizedBox(width: 8),
              Text('Tìm bạn... '),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated wave container
              SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer wave
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(seconds: 2),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.5 + (value * 0.5),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor
                                    .withOpacity(1 - value),
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                      onEnd: () {
                        // This will restart the animation
                      },
                    ),
                    // Middle wave
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1600),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.3 + (value * 0.4),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor
                                    .withOpacity(1 - value),
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Inner wave
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 1200),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.1 + (value * 0.3),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryColor
                                    .withOpacity(1 - value),
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Center NFC icon
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.nfc,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Please hold your NFC card near the device...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              // Animated dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(milliseconds: 600 + (index * 200)),
                    builder: (context, value, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(value),
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                NfcManager.instance.stopSession();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _showStudentCardPopup(
      BuildContext context, StudentCardData studentCardData) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                    spreadRadius: 5,
                  ),
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    blurRadius: 60,
                    offset: const Offset(0, 20),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.8),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_pin,
                      color: Colors.green.shade600,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tìm thấy',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gửi lời mời kết bạn để có thể trò chuyện',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Enhanced student card with hover effect
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: StudentCard(
                      studentCardData: studentCardData,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Enhanced action buttons
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Add chat functionality here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 8,
                            shadowColor:
                                AppColors.primaryColor.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_bubble_outline, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Start Chat',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Enhanced multi-layered animation
        final scaleAnimation = Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.elasticOut,
        ));

        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
        ));

        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        ));

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: child,
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserList({required List<ChatUser> users}) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.8),
                        Colors.grey.shade50.withOpacity(0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: UserBubble(
                    user: users[index],
                    onTap: () {},
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatRoomList(List<MessageRoom> messageRooms) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: messageRooms.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ChatRoomItem(messageRoom: messageRooms[index]),
        );
      },
    );
  }

  // Test method for new chat functionality
  void _showTestChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Test Chat API'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'This will test the chat functionality using your authenticated user.'),
            SizedBox(height: 16),
            Text('Features to test:'),
            Text('• Connect to chat (uses your login)'),
            Text('• Get online users'),
            Text('• Search users'),
            Text('• Send messages'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to the test chat screen
              context.push('/test-chat');
            },
            child: const Text('Start Test'),
          ),
        ],
      ),
    );
  }
}
