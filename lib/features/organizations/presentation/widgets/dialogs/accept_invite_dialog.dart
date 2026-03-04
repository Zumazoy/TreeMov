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
    return AlertDialog(
      title: const Text('Принять приглашение'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Вы хотите присоединиться к организации:'),
          const SizedBox(height: 8),
          Text(
            organizationName,
            style: AppTextStyles.ttNorms16W600.copyWith(
              color: AppColors.notesDarkText,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.plusButton,
            foregroundColor: AppColors.white,
          ),
          child: const Text('Принять'),
        ),
      ],
    );
  }
}
