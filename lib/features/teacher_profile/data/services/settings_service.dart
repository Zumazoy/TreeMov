import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  // Ключи для сохранения настроек
  static const String keyNotifications = 'notifications_enabled';
  static const String keyEmail = 'email_notifications_enabled';
  static const String keyPush = 'push_notifications_enabled';
  static const String keyDarkMode = 'dark_mode_enabled';
  static const String keyPhotos = 'show_photos_in_lists';
  static const String keySound = 'sound_enabled';
  static const String keyAutoSave = 'auto_save_enabled';

  /// Загружает все настройки. Возвращает Map с значениями.
  Future<Map<String, bool>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      keyNotifications: prefs.getBool(keyNotifications) ?? true,
      keyEmail: prefs.getBool(keyEmail) ?? false,
      keyPush: prefs.getBool(keyPush) ?? true,
      keyDarkMode: prefs.getBool(keyDarkMode) ?? false,
      keyPhotos: prefs.getBool(keyPhotos) ?? true,
      keySound: prefs.getBool(keySound) ?? true,
      keyAutoSave: prefs.getBool(keyAutoSave) ?? true,
    };
  }

  /// Сохраняет конкретную настройку по ключу
  Future<void> updateSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}
