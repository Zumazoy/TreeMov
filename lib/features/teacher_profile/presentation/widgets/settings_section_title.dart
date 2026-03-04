import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

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
    final theme = Theme.of(context); // 👈 ПОЛУЧАЕМ ТЕМУ

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: theme.colorScheme.primary, // 👈 ИСПРАВЛЕНО
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTextStyles.ttNorms18W700.themed(context), // 👈 ИСПРАВЛЕНО
          ),
        ],
      ),
    );
  }
}
