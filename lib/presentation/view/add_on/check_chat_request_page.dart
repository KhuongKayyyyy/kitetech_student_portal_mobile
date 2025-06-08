import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_request_approved_item.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_request_received_item.dart';
import 'package:kitetech_student_portal/presentation/widget/chat/chat_request_sent_item.dart';

class CheckChatRequestPage extends StatefulWidget {
  const CheckChatRequestPage({super.key});

  @override
  State<CheckChatRequestPage> createState() => _CheckChatRequestPageState();
}

class _CheckChatRequestPageState extends State<CheckChatRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lời mời kết bạn',
          style: AppTextStyle.title,
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              labelStyle: AppTextStyle.body,
              tabs: [
                Tab(text: 'Đã gửi'),
                Tab(text: 'Nhận'),
                Tab(text: 'Đã chấp nhận'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Sent requests tab
                  ListView.builder(
                    itemCount: FakeData.sentRequest
                        .length, // Replace with actual sent requests count
                    itemBuilder: (context, index) {
                      return ChatRequestSentItem(
                        chatRequest: FakeData.sentRequest[index],
                      );
                    },
                  ),
                  // Received requests tab
                  ListView.builder(
                    itemCount: FakeData.receivedRequest
                        .length, // Replace with actual received requests count
                    itemBuilder: (context, index) {
                      return ChatRequestReceivedItem(
                        chatRequest: FakeData.receivedRequest[index],
                      );
                    },
                  ),
                  // Accepted requests tab
                  ListView.builder(
                    itemCount: FakeData.approvedRequest
                        .length, // Replace with actual accepted requests count
                    itemBuilder: (context, index) {
                      return ChatRequestApprovedItem(
                          chatRequest:
                              FakeData.approvedRequest.elementAt(index));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
