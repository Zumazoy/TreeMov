import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/widgets/auth/logout_dialog.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/profile_header_card.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_appearance_section.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_notifications_section.dart';
// Импорты новых секций
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_profile_section.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_security_section.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_support_section.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_system_section.dart';
import 'package:treemov/shared/data/models/teacher_profile_response_model.dart';

class SettingsScreen extends StatefulWidget {
  final TeacherProfileResponseModel? teacherProfile;

  const SettingsScreen({super.key, required this.teacherProfile});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Состояние (в реальном приложении лучше использовать Bloc/Provider)
  bool _notificationsEnabled = true;
  bool _emailNotificationsEnabled = false;
  bool _pushNotificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _showPhotosInLists = true;
  bool _soundEnabled = true;
  bool _autoSaveEnabled = true;

  // Методы-заглушки для навигации
  void _navigate(String destination) {
    print('Navigate to: $destination');
    // Здесь будет логика навигации
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.notesBackground,
      appBar: AppBar(
        title: const Text(
          'Настройки',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: AppColors.notesDarkText,
          ),
        ),
        backgroundColor: AppColors.notesBackground,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // 1. Профиль (Header)
          ProfileHeaderCard(teacherProfile: widget.teacherProfile),
          const SizedBox(height: 16),

          SettingsProfileSection(
            onEditProfileTap: () => _navigate('Edit Profile'),
            onChangePhotoTap: () => _navigate('Change Photo'),
          ),

          SettingsNotificationsSection(
            notificationsEnabled: _notificationsEnabled,
            emailNotificationsEnabled: _emailNotificationsEnabled,
            pushNotificationsEnabled: _pushNotificationsEnabled,
            onNotificationsChanged: (v) =>
                setState(() => _notificationsEnabled = v),
            onEmailChanged: (v) =>
                setState(() => _emailNotificationsEnabled = v),
            onPushChanged: (v) => setState(() => _pushNotificationsEnabled = v),
          ),

          SettingsAppearanceSection(
            darkModeEnabled: _darkModeEnabled,
            showPhotosInLists: _showPhotosInLists,
            onDarkModeChanged: (v) => setState(() => _darkModeEnabled = v),
            onShowPhotosChanged: (v) => setState(() => _showPhotosInLists = v),
          ),

          SettingsSystemSection(
            soundEnabled: _soundEnabled,
            autoSaveEnabled: _autoSaveEnabled,
            onSoundChanged: (v) => setState(() => _soundEnabled = v),
            onAutoSaveChanged: (v) => setState(() => _autoSaveEnabled = v),
          ),

          SettingsSecuritySection(
            onChangePasswordTap: () => _navigate('Change Password'),
            onTwoFactorTap: () => _navigate('2FA Settings'),
          ),

          SettingsSupportSection(
            onHelpTap: () => _navigate('Help'),
            onFeedbackTap: () => _navigate('Feedback'),
            onAboutTap: () => _navigate('About'),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton(
              onPressed: () => LogoutDialog.show(context: context),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: const BorderSide(color: Colors.red, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: Colors.red,
              ),
              child: const Text(
                'Выйти из аккаунта',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
