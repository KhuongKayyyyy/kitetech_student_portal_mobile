import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';

class AppFunctionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const AppFunctionItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
              )),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
