import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/util/fake_data.dart';
import 'package:kitetech_student_portal/data/model/name_recognition.dart';
import 'package:kitetech_student_portal/presentation/bloc/name_recognition/name_recognition_bloc.dart';
import 'package:kitetech_student_portal/presentation/widget/timetable/name_recognition_history_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NameRecognitionHistoryPage extends StatefulWidget {
  const NameRecognitionHistoryPage({super.key});

  @override
  State<NameRecognitionHistoryPage> createState() =>
      _NameRecognitionHistoryPageState();
}

class _NameRecognitionHistoryPageState
    extends State<NameRecognitionHistoryPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<NameRecognitionBloc>()
        .add(NameRecognitionGetByStudentIdEvent(studentId: '52100973'));
  }

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
      body: BlocBuilder<NameRecognitionBloc, NameRecognitionState>(
        builder: (context, nameRecognitionState) {
          if (nameRecognitionState is NameRecognitionLoaded) {
            return _buildItemList(
                nameRecognitions: nameRecognitionState.nameRecognition);
          } else if (nameRecognitionState is NameRecognitionLoading) {
            return Skeletonizer(
                child: _buildItemList(
                    nameRecognitions: FakeData.nameRecognitions));
          } else if (nameRecognitionState is NameRecognitionError) {
            return Center(child: Text(nameRecognitionState.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  ListView _buildItemList({required List<NameRecognition> nameRecognitions}) {
    return ListView.builder(
      itemBuilder: (context, index) => NameRecognitionHistoryItem(
        nameRecognition: nameRecognitions[index],
      ),
      itemCount: nameRecognitions.length,
    );
  }
}
