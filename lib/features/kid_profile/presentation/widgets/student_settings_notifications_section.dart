import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_card.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_toggle_row.dart';

class StudentSettingsNotificationsSection extends StatelessWidget {
  final bool notificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool pushNotificationsEnabled;
  final bool parentNotificationsEnabled;
  final ValueChanged<bool> onNotificationsChanged;
  final ValueChanged<bool> onEmailChanged;
  final ValueChanged<bool> onPushChanged;
  final ValueChanged<bool> onParentNotificationsChanged;

  const StudentSettingsNotificationsSection({
    super.key,
    required this.notificationsEnabled,
    required this.emailNotificationsEnabled,
    required this.pushNotificationsEnabled,
    required this.parentNotificationsEnabled,
    required this.onNotificationsChanged,
    required this.onEmailChanged,
    required this.onPushChanged,
    required this.onParentNotificationsChanged,
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
              Icon(Icons.notifications_none, size: 24, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Уведомления',
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
            StudentSettingsToggleRow(
              title: 'Уведомления',
              subtitle: 'Получать уведомления в приложении',
              value: notificationsEnabled,
              onChanged: onNotificationsChanged,
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            StudentSettingsToggleRow(
              title: 'Email уведомления',
              subtitle: 'Получать уведомления на почту',
              value: emailNotificationsEnabled,
              onChanged: onEmailChanged,
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            StudentSettingsToggleRow(
              title: 'Push уведомления',
              subtitle: 'Получать push-уведомления',
              value: pushNotificationsEnabled,
              onChanged: onPushChanged,
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            StudentSettingsToggleRow(
              title: 'Уведомления для родителей',
              subtitle: 'Отправлять копии уведомлений родителям',
              value: parentNotificationsEnabled,
              onChanged: onParentNotificationsChanged,
            ),
          ],
        ),
      ],
    );
  }
}
