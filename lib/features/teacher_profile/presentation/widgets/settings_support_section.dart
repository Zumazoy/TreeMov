import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_card.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_nav_row.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_section_title.dart';

class SettingsSupportSection extends StatelessWidget {
  final VoidCallback onHelpTap;
  final VoidCallback onFeedbackTap;
  final VoidCallback onAboutTap;

  const SettingsSupportSection({
    super.key,
    required this.onHelpTap,
    required this.onFeedbackTap,
    required this.onAboutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingsSectionTitle(
          title: 'Поддержка',
          icon: Icons.help_outline,
        ),
        SettingsCard(
          children: [
            SettingsNavRow(
              title: 'Справка',
              subtitle: 'Руководство пользователя',
              onTap: onHelpTap,
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
              onTap: onFeedbackTap,
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
              onTap: onAboutTap,
            ),
          ],
        ),
      ],
    );
  }
}
