import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class CreateOrganizationDialog extends StatelessWidget {
  final Function(String name) onConfirm;

  const CreateOrganizationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return AlertDialog(
      title: const Text('Создать организацию'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Название организации',
          border: OutlineInputBorder(),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onConfirm(controller.text);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.plusButton,
            foregroundColor: AppColors.white,
          ),
          child: const Text('Создать'),
        ),
      ],
    );
  }
}
