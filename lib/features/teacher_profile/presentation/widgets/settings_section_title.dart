import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class SettingsSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const SettingsSectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 24, color: AppColors.teacherPrimary),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.notesDarkText,
            ),
          ),
        ],
      ),
    );
  }
}
