import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class AcceptInviteDialog extends StatelessWidget {
  final String organizationName;
  final VoidCallback onConfirm;

  const AcceptInviteDialog({
    super.key,
    required this.organizationName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark ? AppColors.darkCard : null,
      title: Text(
        'Принять приглашение',
        style: TextStyle(color: isDark ? AppColors.darkText : null),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Вы хотите присоединиться к организации:',
            style: TextStyle(
              color: isDark ? AppColors.darkTextSecondary : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            organizationName,
            style: AppTextStyles.ttNorms16W600.copyWith(
              color: isDark ? AppColors.darkText : AppColors.notesDarkText,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Отмена',
            style: TextStyle(
              color: isDark ? AppColors.darkTextSecondary : null,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Принять'),
        ),
      ],
    );
  }
}
