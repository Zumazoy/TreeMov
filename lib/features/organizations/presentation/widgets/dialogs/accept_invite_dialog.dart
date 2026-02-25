import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
