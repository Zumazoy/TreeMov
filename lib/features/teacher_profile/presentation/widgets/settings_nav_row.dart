import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class SettingsNavRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsNavRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(title, style: AppTextStyles.ttNorms16W500.themed(context)),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.ttNorms12W400.copyWith(
          color: theme.textTheme.bodySmall?.color,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: theme.colorScheme.primary,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: onTap,
    );
  }
}
