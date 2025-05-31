import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';

class StudentDetailInformationPage extends StatelessWidget {
  const StudentDetailInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin sinh viên",
          style: AppTextStyle.title,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _builderEnrollmentInformation("Thông tin nhập học"),
            _builderEnrollmentInformation("Thông tin sinh viên"),
            _builderEnrollmentInformation("Thông tin liên lạc"),
            _builderEnrollmentInformation("Quan hệ gia đình"),
          ],
        ),
      ),
    );
  }

  Widget _builderEnrollmentInformation(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              _buildInformationRowItem("Mã sinh viên", "1234567890"),
              _buildInformationRowItem("Họ tên", "Nguyễn Văn A"),
              _buildInformationRowItem("Ngày sinh", "12/12/2000"),
              _buildInformationRowItem("Giới tính", "Nam"),
              _buildInformationRowItem("Khu vực", "1"),
              _buildInformationRowItem("Ngành", "Công nghệ thông tin"),
              _buildInformationRowItem("Lớp", "1234567890"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInformationRowItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(title),
          ),
          Expanded(
            flex: 6,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
