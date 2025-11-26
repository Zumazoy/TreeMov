import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.teacherPrimary.withAlpha(51),
              border: Border.all(color: AppColors.teacherPrimary, width: 1.5),
            ),
            child: const Center(
              child: Text(
                'ЕП',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.teacherPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Елена Ивановна Петрова',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.notesDarkText,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Преподаватель по робототехнике',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.directoryTextSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
