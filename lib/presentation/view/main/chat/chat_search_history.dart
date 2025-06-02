import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_room_search_item.dart';

class ChatSearchHistory extends StatefulWidget {
  const ChatSearchHistory({super.key});

  @override
  State<ChatSearchHistory> createState() => _ChatSearchHistoryState();
}

class _ChatSearchHistoryState extends State<ChatSearchHistory> {
  List<dynamic> _recentSearchUsers = [];

  @override
  void initState() {
    super.initState();
    _recentSearchUsers = FakeData.chatUsers.take(3).toList();
  }

  void _clearSearchHistory() {
    setState(() {
      _recentSearchUsers.clear();
    });
  }

  void _removeUser(int index) {
    setState(() {
      _recentSearchUsers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử tìm kiếm'),
        actions: [
          if (_recentSearchUsers.isNotEmpty)
            TextButton(
              onPressed: _clearSearchHistory,
              child: const Text(
                'Xóa tất cả',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: _recentSearchUsers.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Không có lịch sử tìm kiếm',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Vuốt sang trái để xóa lịch sử tìm kiếm',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _recentSearchUsers.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(_recentSearchUsers[index].id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          _removeUser(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Đã xóa khỏi lịch sử tìm kiếm'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ChatRoomSearchItem(
                            user: _recentSearchUsers[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
