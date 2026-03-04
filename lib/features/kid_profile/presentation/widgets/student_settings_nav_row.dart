import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class StudentSettingsNavRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const StudentSettingsNavRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: AppTextStyles.ttNorms16W500.copyWith(
          color: AppColors.notesDarkText,
        ),
      ),
      subtitle: Text(subtitle, style: AppTextStyles.ttNorms12W400.grey),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.kidButton,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: onTap,
    );
  }
}
