import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  // --- Light Theme ---
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    useMaterial3: true,
    brightness: Brightness.light,

    // Base Colors
    scaffoldBackgroundColor: AppColors.white,
    canvasColor: AppColors.white,
    cardColor: AppColors.white,
    dividerColor: AppColors.selectedDateBackground,
    // Text
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.notesDarkText),
      bodyMedium: TextStyle(color: AppColors.notesDarkText),
      titleLarge: TextStyle(color: AppColors.notesDarkText),
    ),

    // App Bar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.notesDarkText,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    // Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.teacherPrimary,
        foregroundColor: AppColors.white,
      ),
    ),

    // Input/Form Fields (Light)
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.eventTap),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.teacherPrimary),
      ),
      hintStyle: TextStyle(color: AppColors.grayFieldText),
      labelStyle: TextStyle(color: AppColors.grayFieldText),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.selectedDateBackground,
      thickness: 1,
      space: 1,
    ),

    // Card Theme
    cardTheme: const CardThemeData(
      color: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );

  // --- Dark Theme Helpers ---
  static final CardThemeData _darkCardTheme = CardThemeData(
    color: AppColors.darkCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: AppColors.darkSurface, width: 1),
    ),
  );

  static final SwitchThemeData _darkSwitchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.teacherPrimary;
      }
      return AppColors.darkText;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.teacherPrimary.withAlpha(128);
      }
      return AppColors.darkSurface;
    }),
  );

  // --- Dark Theme Definition ---
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    useMaterial3: true,
    brightness: Brightness.dark,

    // Base Colors
    scaffoldBackgroundColor: AppColors.darkBackground,
    canvasColor: AppColors.darkSurface,
    cardColor: AppColors.darkCard,
    dividerColor: AppColors.darkTextSecondary,
    // Text
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText),
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
      titleLarge: TextStyle(color: AppColors.darkText),
    ),

    // App Bar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkText,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    // Input/Form Fields
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.darkCard,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkSurface),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.teacherPrimary),
      ),
      hintStyle: TextStyle(color: AppColors.darkTextSecondary),
      labelStyle: TextStyle(color: AppColors.darkTextSecondary),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.darkTextSecondary,
      thickness: 1,
      space: 1,
    ),

    // Card
    cardTheme: _darkCardTheme,

    // Switch
    switchTheme: _darkSwitchTheme,

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.teacherPrimary,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
