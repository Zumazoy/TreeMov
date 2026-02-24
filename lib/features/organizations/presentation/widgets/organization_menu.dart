import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class OrganizationMenu extends StatelessWidget {
  final String userRole;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback onLeave;

  const OrganizationMenu({
    super.key,
    required this.userRole,
    this.onEdit,
    this.onDelete,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit?.call();
            break;
          case 'delete':
            onDelete?.call();
            break;
          case 'leave':
            onLeave();
            break;
        }
      },
      itemBuilder: (context) {
        List<PopupMenuEntry<String>> items = [];

        if (userRole == 'Администратор') {
          items.addAll([
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20, color: AppColors.grayFieldText),
                  SizedBox(width: 12),
                  Text('Редактировать'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20, color: Colors.red),
                  SizedBox(width: 12),
                  Text(
                    'Удалить организацию',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
          ]);
        }

        items.add(
          const PopupMenuItem(
            value: 'leave',
            child: Row(
              children: [
                Icon(Icons.exit_to_app, size: 20, color: Colors.orange),
                SizedBox(width: 12),
                Text('Покинуть организацию'),
              ],
            ),
          ),
        );

        return items;
      },
    );
  }
}
