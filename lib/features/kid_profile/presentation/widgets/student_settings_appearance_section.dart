import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_card.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_toggle_row.dart';

class StudentSettingsAppearanceSection extends StatelessWidget {
  final bool darkModeEnabled;
  final bool showProgress;
  final bool showPhotosInLists;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<bool> onShowProgressChanged;
  final ValueChanged<bool> onShowPhotosChanged;

  const StudentSettingsAppearanceSection({
    super.key,
    required this.darkModeEnabled,
    required this.showProgress,
    required this.showPhotosInLists,
    required this.onDarkModeChanged,
    required this.onShowProgressChanged,
    required this.onShowPhotosChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
          child: Row(
            children: [
              const Icon(
                Icons.brightness_6_outlined,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text('Внешний вид', style: AppTextStyles.ttNorms18W700.white),
            ],
          ),
        ),
        StudentSettingsCard(
          children: [
            StudentSettingsToggleRow(
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
            StudentSettingsToggleRow(
              title: 'Показывать прогресс',
              subtitle: 'Отображать прогресс на главной',
              value: showProgress,
              onChanged: onShowProgressChanged,
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            StudentSettingsToggleRow(
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
