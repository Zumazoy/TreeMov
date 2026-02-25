import 'package:shared_preferences/shared_preferences.dart';

class StudentSettingsService {
  // Ключи для сохранения настроек ученика
  static const String keyNotifications = 'student_notifications_enabled';
  static const String keyEmail = 'student_email_notifications_enabled';
  static const String keyPush = 'student_push_notifications_enabled';
  static const String keyDarkMode = 'student_dark_mode_enabled';
  static const String keyShowProgress = 'student_show_progress';
  static const String keySound = 'student_sound_enabled';
  static const String keyAutoSave = 'student_auto_save_enabled';
  static const String keyParentNotifications = 'student_parent_notifications';

  /// Загружает все настройки ученика
  Future<Map<String, bool>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      keyNotifications: prefs.getBool(keyNotifications) ?? true,
      keyEmail: prefs.getBool(keyEmail) ?? false,
      keyPush: prefs.getBool(keyPush) ?? true,
      keyDarkMode: prefs.getBool(keyDarkMode) ?? false,
      keyShowProgress: prefs.getBool(keyShowProgress) ?? true,
      keySound: prefs.getBool(keySound) ?? true,
      keyAutoSave: prefs.getBool(keyAutoSave) ?? true,
      keyParentNotifications: prefs.getBool(keyParentNotifications) ?? false,
    };
  }

  /// Сохраняет конкретную настройку
  Future<void> updateSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}
