import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/data/model/name_recognition.dart';
import 'package:kitetech_student_portal/presentation/widget/timetable/name_recognition_history_item.dart';

class NameRecognitionHistoryPage extends StatefulWidget {
  const NameRecognitionHistoryPage({super.key});

  @override
  State<NameRecognitionHistoryPage> createState() =>
      _NameRecognitionHistoryPageState();
}

class _NameRecognitionHistoryPageState
    extends State<NameRecognitionHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử điểm danh', style: AppTextStyle.title),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Tổng ${FakeData.nameRecognitions.length}",
              style: const TextStyle(color: Colors.black),
            ),
          ))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => NameRecognitionHistoryItem(
          nameRecognition: FakeData.nameRecognitions[index],
        ),
        itemCount: FakeData.nameRecognitions.length,
      ),
    );
  }
}
