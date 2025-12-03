import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class SettingsToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggleRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.notesDarkText,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.directoryTextSecondary,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.teacherPrimary,
        activeTrackColor: AppColors.teacherPrimary.withAlpha(128),
        inactiveThumbColor: AppColors.grey,
        inactiveTrackColor: AppColors.lightGrey,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: () => onChanged(!value),
    );
  }
}
