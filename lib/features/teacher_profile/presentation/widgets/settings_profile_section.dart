import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/organizations/presentation/screens/organizations_screen.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_card.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_nav_row.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_section_title.dart';

class SettingsProfileSection extends StatelessWidget {
  final VoidCallback onEditProfileTap;
  final VoidCallback onChangePhotoTap;

  const SettingsProfileSection({
    super.key,
    required this.onEditProfileTap,
    required this.onChangePhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingsSectionTitle(
          title: 'Профиль',
          icon: Icons.person_outline,
        ),
        SettingsCard(
          children: [
            SettingsNavRow(
              title: 'Редактировать профиль',
              subtitle: 'Изменить личные данные',
              onTap: onEditProfileTap,
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
              onTap: onChangePhotoTap,
            ),

            // НОВАЯ КНОПКА: Мои организации
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),

            // Специальный ListTile для организаций
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.plusButton.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.business,
                  color: AppColors.plusButton,
                  size: 20,
                ),
              ),
              title: const Text(
                'Мои организации',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.notesDarkText,
                ),
              ),
              subtitle: const Text(
                'Управление организациями и приглашениями',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.directoryTextSecondary,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.teacherPrimary,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrganizationsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
