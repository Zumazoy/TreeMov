import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeader({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.directoryTextSecondary),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTextStyles.ttNorms16W600.copyWith(
              color: AppColors.grayFieldText,
            ),
          ),
        ],
      ),
    );
  }
}
