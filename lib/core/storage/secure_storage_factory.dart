import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:treemov/core/storage/secure_storage_repository.dart';
import 'package:treemov/core/storage/secure_storage_repository_impl.dart';
import 'package:treemov/core/storage/secure_storage_repository_shared_prefs.dart';

class SecureStorageFactory {
  static SecureStorageRepository create() {
    print('🔧 Creating storage for platform: ${kIsWeb ? "WEB" : "MOBILE"}');
    if (kIsWeb) {
      print('✅ Using SecureStorageRepositoryWeb');
      return SecureStorageRepositorySharedPrefs();
    } else {
      print('✅ Using SecureStorageRepositoryImpl');
      return SecureStorageRepositoryImpl();
    }
  }
}
