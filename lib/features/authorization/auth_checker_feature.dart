import 'package:flutter/material.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/authorization/domain/repositories/auth_storage_repository.dart';
import 'package:treemov/features/authorization/presentation/screens/auth_checker_screen.dart';
import 'package:treemov/features/authorization/presentation/screens/entrance_screen.dart';

class AuthCheckerFeature {
  static Widget createAuthChecker() {
    return AuthCheckerScreen(
      authStorageRepository: getIt<AuthStorageRepository>(),
    );
  }

  static Widget createEntranceScreen() {
    return const EntranceScreen();
  }
}
