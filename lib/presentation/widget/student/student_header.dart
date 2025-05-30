import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_image.dart';
import 'package:kitetech_student_portal/data/model/student.dart';

class StudentHeader extends StatelessWidget {
  final Student student;
  final bool isExpanded;

  const StudentHeader({
    super.key,
    required this.student,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      title: !isExpanded
          ? const Text(
              "Trang chủ",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          : null,
      background: isExpanded ? _buildExpandedContent() : null,
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      height: 100,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              AppImage.defaultAvatar,
              height: 50,
              width: 50,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                student.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                student.studentId,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                student.major,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          Image.asset(
            AppImage.logo,
            height: 50,
            width: 50,
          ),
        ],
      ),
    );
  }
}
