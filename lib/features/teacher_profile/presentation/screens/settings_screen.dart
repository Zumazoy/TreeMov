import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/widgets/auth/logout_dialog.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/profile_header_card.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_nav_row.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_section_title.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_toggle_row.dart';
import 'package:treemov/shared/data/models/teacher_profile_response_model.dart';

class SettingsScreen extends StatefulWidget {
  final TeacherProfileResponseModel? teacherProfile;

  const SettingsScreen({super.key, required this.teacherProfile});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotificationsEnabled = false;
  bool _pushNotificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _showPhotosInLists = true;
  bool _soundEnabled = true;
  bool _autoSaveEnabled = true;

  Widget _buildCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
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

          // 2. Секция "Профиль"
          const SettingsSectionTitle(
            title: 'Профиль',
            icon: Icons.person_outline,
          ),
          _buildCard([
            SettingsNavRow(
              title: 'Редактировать профиль',
              subtitle: 'Изменить личные данные',
              onTap: () {},
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            SettingsNavRow(
              title: 'Изменить фото',
              subtitle: 'Загрузить новое фото профиля',
              onTap: () {},
            ),
          ]),

          // 3. Секция "Уведомления"
          const SettingsSectionTitle(
            title: 'Уведомления',
            icon: Icons.notifications_none,
          ),
          _buildCard([
            SettingsToggleRow(
              title: 'Уведомления',
              subtitle: 'Получать уведомления в приложении',
              value: _notificationsEnabled,
              onChanged: (v) => setState(() => _notificationsEnabled = v),
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            SettingsToggleRow(
              title: 'Email уведомления',
              subtitle: 'Получать уведомления на почту',
              value: _emailNotificationsEnabled,
              onChanged: (v) => setState(() => _emailNotificationsEnabled = v),
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            SettingsToggleRow(
              title: 'Push уведомления',
              subtitle: 'Получать push-уведомления на устройство',
              value: _pushNotificationsEnabled,
              onChanged: (v) => setState(() => _pushNotificationsEnabled = v),
            ),
          ]),

          // 4. Секция "Внешний вид"
          const SettingsSectionTitle(
            title: 'Внешний вид',
            icon: Icons.brightness_6_outlined,
          ),
          _buildCard([
            SettingsToggleRow(
              title: 'Тёмная тема',
              subtitle: 'Использовать тёмное оформление',
              value: _darkModeEnabled,
              onChanged: (v) => setState(() => _darkModeEnabled = v),
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            SettingsToggleRow(
              title: 'Фото учеников',
              subtitle: 'Показывать фотографии в списках',
              value: _showPhotosInLists,
              onChanged: (v) => setState(() => _showPhotosInLists = v),
            ),
          ]),

          // 5. Секция "Система" (Первая часть)
          const SettingsSectionTitle(
            title: 'Система',
            icon: Icons.settings_outlined,
          ),
          _buildCard([
            SettingsToggleRow(
              title: 'Звуки',
              subtitle: 'Воспроизводить звуки уведомлений',
              value: _soundEnabled,
              onChanged: (v) => setState(() => _soundEnabled = v),
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            SettingsToggleRow(
              title: 'Автосохранение',
              subtitle: 'Автоматически сохранять изменения',
              value: _autoSaveEnabled,
              onChanged: (v) => setState(() => _autoSaveEnabled = v),
            ),
          ]),

          // 6. Секция "Безопасность"
          const SettingsSectionTitle(
            title: 'Безопасность',
            icon: Icons.security_outlined,
          ),
          _buildCard([
            SettingsNavRow(
              title: 'Сменить пароль',
              subtitle: 'Изменить пароль для входа',
              onTap: () {},
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            SettingsNavRow(
              title: 'Двухфакторная аутентификация',
              subtitle: 'Настроить дополнительную защиту',
              onTap: () {},
            ),
          ]),

          // 7. Секция "Система" (Поддержка и информация)
          const SettingsSectionTitle(
            title: 'Система',
            icon: Icons.help_outline,
          ),
          _buildCard([
            SettingsNavRow(
              title: 'Справка',
              subtitle: 'Руководство пользователя',
              onTap: () {},
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            SettingsNavRow(
              title: 'Обратная связь',
              subtitle: 'Отправить отзыв или предложение',
              onTap: () {},
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            SettingsNavRow(
              title: 'О системе',
              subtitle: 'Версия 1.2.3',
              onTap: () {},
            ),
          ]),

          const SizedBox(height: 24),

          // 8. Кнопка "Выйти из аккаунта"
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
