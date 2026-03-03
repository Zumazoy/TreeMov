import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_card.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_nav_row.dart';

class StudentSettingsSupportSection extends StatelessWidget {
  final VoidCallback onHelpTap;
  final VoidCallback onFeedbackTap;
  final VoidCallback onAboutTap;

  const StudentSettingsSupportSection({
    super.key,
    required this.onHelpTap,
    required this.onFeedbackTap,
    required this.onAboutTap,
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
              Icon(Icons.help_outline, size: 24, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Поддержка',
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
            StudentSettingsNavRow(
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
            StudentSettingsNavRow(
              title: 'О приложении',
              subtitle: 'Версия 1.0.0',
              onTap: onAboutTap,
            ),
          ],
        ),
      ],
    );
  }
}
