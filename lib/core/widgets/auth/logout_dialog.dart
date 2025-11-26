import 'package:flutter/material.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_storage_repository.dart';

class LogoutDialog {
  static Future<void> show({required BuildContext context}) async {
    final authStorageRepository = getIt<AuthStorageRepository>();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выход из аккаунта'),
        content: const Text('Вы уверены, что хотите выйти?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _performLogout(context, authStorageRepository);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }

  static Future<void> _performLogout(
    BuildContext context,
    AuthStorageRepository authStorageRepository,
  ) async {
    try {
      await authStorageRepository.clearAllTokens();

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.entrance,
          (route) => false,
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при выходе: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
