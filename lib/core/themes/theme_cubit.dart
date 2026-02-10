import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/features/profile/data/datasources/settings_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SettingsService _settingsService;

  ThemeCubit(this._settingsService) : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final settings = await _settingsService.loadSettings();
    final isDark = settings[SettingsService.keyDarkMode] ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> setTheme(bool isDark) async {
    // Сохраняем в настройки
    await _settingsService.updateSetting(SettingsService.keyDarkMode, isDark);
    // Обновляем состояние приложения
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
