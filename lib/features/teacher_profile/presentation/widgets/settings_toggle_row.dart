import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

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
    final theme = Theme.of(context); // 👈 ПОЛУЧАЕМ ТЕМУ

    return ListTile(
      title: Text(
        title,
        style: AppTextStyles.ttNorms16W500.themed(context), // 👈 ИСПРАВЛЕНО
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.ttNorms12W400.copyWith(
          color: theme.textTheme.bodySmall?.color, // 👈 ИСПРАВЛЕНО
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: theme.colorScheme.primary, // 👈 ИСПРАВЛЕНО
        activeTrackColor: theme.colorScheme.primary.withAlpha(
          128,
        ), // 👈 ИСПРАВЛЕНО
        inactiveThumbColor: theme.unselectedWidgetColor, // 👈 ИСПРАВЛЕНО
        inactiveTrackColor: theme.disabledColor, // 👈 ИСПРАВЛЕНО
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: () => onChanged(!value),
    );
  }
}
