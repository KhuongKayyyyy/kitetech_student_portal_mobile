import 'package:flutter/material.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_text_style.dart';
import 'package:kitetech_student_portal/core/util/string_util.dart';

import 'package:kitetech_student_portal/data/model/name_recognition.dart';

class NameRecognitionHistoryItem extends StatelessWidget {
  final NameRecognition nameRecognition;
  const NameRecognitionHistoryItem({super.key, required this.nameRecognition});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            child: const Icon(
              Icons.school,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameRecognition.name ?? '',
                  style: AppTextStyle.bodyBold,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(StringUtil.formatDate(nameRecognition.time)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.4),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
