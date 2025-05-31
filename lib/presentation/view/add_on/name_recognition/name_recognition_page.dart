import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';

class NameRecognitionPage extends StatefulWidget {
  const NameRecognitionPage({super.key});

  @override
  State<NameRecognitionPage> createState() => _NameRecognitionPageState();
}

class _NameRecognitionPageState extends State<NameRecognitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Điểm danh",
          style: AppTextStyle.title,
        ),
        backgroundColor: AppColors.primaryColor.withOpacity(0.2),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildRecognitionSection(
              "Quét Mã",
              () => context.pushNamed(AppRouter.nameRecognitionQrScanner),
              Icons.qr_code),
          _buildRecognitionSection(
              "Nhập pin",
              () => context.pushNamed(AppRouter.nameRecognitionPinPage),
              Icons.pin),
          _buildRecognitionSection(
              "Lịch sử điểm danh",
              () => context.pushNamed(AppRouter.nameRecognitionHistoryPage),
              Icons.check),
        ],
      ),
    );
  }

  Widget _buildRecognitionSection(
      String title, VoidCallback onTap, IconData icon) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: AppColors.primaryColor,
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
