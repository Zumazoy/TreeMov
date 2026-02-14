import 'package:flutter/material.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/authorization/presentation/screens/auth_checker_screen.dart';
import 'package:treemov/features/authorization/presentation/screens/entrance_screen.dart';
import 'package:treemov/shared/storage/domain/repositories/secure_storage_repository.dart';

class AuthCheckerFeature {
  static Widget createAuthChecker() {
    return AuthCheckerScreen(
      secureStorageRepository: getIt<SecureStorageRepository>(),
    );
  }

  static Widget createEntranceScreen() {
    return const EntranceScreen();
  }
}
