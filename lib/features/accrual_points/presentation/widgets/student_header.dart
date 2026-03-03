import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

import 'student_avatar.dart';

class StudentHeader extends StatelessWidget {
  final StudentEntity student;
  final VoidCallback onClose;

  const StudentHeader({
    super.key,
    required this.student,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.eventTap, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          StudentAvatar(avatarUrl: null, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${student.name} ${student.surname}',
                  style: AppTextStyles.arial14W700.dark,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/energy_icon.png',
                      width: 16,
                      height: 16,
                      color: AppColors.directoryTextSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${student.score} баллов',
                      style: AppTextStyles.arial12W400.grey, // 👈
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close, size: 24, color: AppColors.teacherPrimary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}
