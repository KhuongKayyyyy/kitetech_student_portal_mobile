import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:kitetech_student_portal/core/constant/app_image.dart';
import 'package:kitetech_student_portal/data/respository/student_card_data.dart';

class StudentDetailCard extends StatelessWidget {
  final Function()? onTap;
  final StudentCardData studentCardData;
  const StudentDetailCard(
      {super.key, required this.studentCardData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppImage.logo, // Place your logo here
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TỔNG LIÊN ĐOÀN LAO ĐỘNG VIỆT NAM',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'TRƯỜNG ĐẠI HỌC KITE TECH',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 2),
                      Center(
                        child: Text(
                          'THẺ SINH VIÊN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Student photo and info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    AppImage
                        .defaultAvatar, // Provide the path to the student photo
                    width: 70,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoRow('Họ và tên:', studentCardData.studentName),
                      Row(
                        children: [
                          Expanded(
                            child: _infoRow(
                                'Ngày sinh:', studentCardData.birthDate),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _infoRow('Phái:', studentCardData.gender),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _infoRow('MSSV:', studentCardData.studentId),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _infoRow('Lớp:', studentCardData.classId),
                          ),
                        ],
                      ),
                      _infoRow('Ngành:', studentCardData.major),
                      _infoRow('Khoa:', studentCardData.department),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Barcode
            BarcodeWidget(
              barcode: Barcode.code128(),
              data: studentCardData.studentId,
              width: 200,
              height: 50,
              drawText: false,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
