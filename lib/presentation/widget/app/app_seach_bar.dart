import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';

class AppSeachBar extends StatelessWidget {
  const AppSeachBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 10, 10, 10).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          enabled: false,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            hintText: "Tìm kiếm chức năng ...",
            prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }
}
