import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_card.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_section_title.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_toggle_row.dart';

class SettingsAppearanceSection extends StatelessWidget {
  final bool darkModeEnabled;
  final bool showPhotosInLists;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<bool> onShowPhotosChanged;

  const SettingsAppearanceSection({
    super.key,
    required this.darkModeEnabled,
    required this.showPhotosInLists,
    required this.onDarkModeChanged,
    required this.onShowPhotosChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingsSectionTitle(
          title: 'Внешний вид',
          icon: Icons.brightness_6_outlined,
        ),
        SettingsCard(
          children: [
            SettingsToggleRow(
              title: 'Тёмная тема',
              subtitle: 'Использовать тёмное оформление',
              value: darkModeEnabled,
              onChanged: onDarkModeChanged,
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
              value: showPhotosInLists,
              onChanged: onShowPhotosChanged,
            ),
          ],
        ),
      ],
    );
  }
}
