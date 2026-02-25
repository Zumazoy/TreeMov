import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_card.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_nav_row.dart';

class StudentSettingsProfileSection extends StatelessWidget {
  final VoidCallback onEditProfileTap;
  final VoidCallback onChangePhotoTap;
  final VoidCallback onMyOrgsTap; // Новый колбэк

  const StudentSettingsProfileSection({
    super.key,
    required this.onEditProfileTap,
    required this.onChangePhotoTap,
    required this.onMyOrgsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 12, bottom: 4),
          child: Row(
            children: [
              Icon(Icons.person_outline, size: 24, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Профиль',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        StudentSettingsCard(
          children: [
            StudentSettingsNavRow(
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
            StudentSettingsNavRow(
              title: 'Изменить аватар',
              subtitle: 'Загрузить новое фото',
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
                  color: AppColors.kidButton.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.business,
                  color: AppColors.kidButton,
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
                color: AppColors.kidButton,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: onMyOrgsTap,
            ),
          ],
        ),
      ],
    );
  }
}
