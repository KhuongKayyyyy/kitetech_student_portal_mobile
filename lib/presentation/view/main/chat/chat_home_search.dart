import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_room_search_item.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/user_bubble.dart';

class ChatHomeSearch extends StatefulWidget {
  const ChatHomeSearch({super.key});

  @override
  State<ChatHomeSearch> createState() => _ChatHomeSearchState();
}

class _ChatHomeSearchState extends State<ChatHomeSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredUsers = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredUsers = FakeData.chatUsers;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredUsers = FakeData.chatUsers;
      } else {
        _filteredUsers = FakeData.chatUsers
            .where((user) =>
                user.firstName!.toLowerCase().contains(query.toLowerCase()) ||
                user.lastName!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 30,
        title: Hero(
          tag: "chat-search",
          child: _buildSearchBar(),
        ),
      ),
      body: _filteredUsers.isEmpty && _isSearching
          ? const Center(
              child: Text(
                'Không tìm thấy kết quả',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          : !_isSearching
              ? _buildSearchHistory()
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ChatRoomSearchItem(
                        user: _filteredUsers[index],
                        onTap: () {},
                      ),
                    );
                  },
                ),
    );
  }

  Column _buildSearchHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Text(
                'Tìm kiếm gần đây',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => context.pushNamed(AppRouter.chatSearchHistory),
                child: const Text(
                  'Chỉnh sửa',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 15,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            itemCount: _filteredUsers.length > 6 ? 6 : _filteredUsers.length,
            itemBuilder: (context, index) {
              return UserBubble(
                user: _filteredUsers[index],
                onTap: () {},
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Gợi ý',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _filteredUsers.take(4).length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ChatRoomSearchItem(
                user: _filteredUsers[index],
                onTap: () {
                  context.pushNamed(AppRouter.chatRoomPage,
                      extra: _filteredUsers[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Container _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                Colors.grey[50]!,
                Colors.grey[100]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: TextField(
            cursorColor: AppColors.primaryColor,
            controller: _searchController,
            onChanged: _onSearchChanged,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm ...',
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.grey[600],
                size: 24,
              ),
              suffixIcon: _isSearching
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        _onSearchChanged('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: false,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
