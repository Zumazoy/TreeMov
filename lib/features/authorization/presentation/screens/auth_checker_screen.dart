import 'package:flutter/material.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/shared/storage/domain/repositories/secure_storage_repository.dart';

class AuthCheckerScreen extends StatefulWidget {
  final SecureStorageRepository secureStorageRepository;

  const AuthCheckerScreen({super.key, required this.secureStorageRepository});

  @override
  State<AuthCheckerScreen> createState() => _AuthCheckerScreenState();
}

class _AuthCheckerScreenState extends State<AuthCheckerScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await widget.secureStorageRepository.getAccessToken();

    if (mounted) {
      if (token != null && token.isNotEmpty) {
        // Токен есть - переходим на главную
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.mainApp,
          (route) => false,
        );
      } else {
        // Токена нет - переходим на авторизацию
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.entrance,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
