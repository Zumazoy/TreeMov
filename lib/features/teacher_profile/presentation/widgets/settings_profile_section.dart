import 'package:flutter/material.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
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
    final theme = Theme.of(context);

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
            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: theme.dividerColor,
            ),
            SettingsNavRow(
              title: 'Изменить фото',
              subtitle: 'Загрузить новое фото профиля',
              onTap: onChangePhotoTap,
            ),

            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: theme.dividerColor,
            ),

            // Специальный ListTile для организаций
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.business,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              title: Text(
                'Мои организации',
                style: AppTextStyles.ttNorms16W500.themed(context),
              ),
              subtitle: Text(
                'Управление организациями и приглашениями',
                style: AppTextStyles.ttNorms12W400.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.myOrgs);
              },
            ),
          ],
        ),
      ],
    );
  }
}
