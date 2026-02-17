import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
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
          ],
        ),
      ],
    );
  }
}
