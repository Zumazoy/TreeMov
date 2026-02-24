import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:treemov/core/storage/secure_storage_repository.dart';
import 'package:treemov/core/storage/secure_storage_repository_impl.dart';
import 'package:treemov/core/storage/secure_storage_repository_shared_prefs.dart';

class SecureStorageFactory {
  static SecureStorageRepository create() {
    if (kIsWeb) {
      return SecureStorageRepositorySharedPrefs();
    } else {
      return SecureStorageRepositoryImpl();
    }
  }
}
