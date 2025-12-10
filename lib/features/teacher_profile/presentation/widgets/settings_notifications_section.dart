import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_card.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_section_title.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_toggle_row.dart';

class SettingsNotificationsSection extends StatelessWidget {
  final bool notificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool pushNotificationsEnabled;
  final ValueChanged<bool> onNotificationsChanged;
  final ValueChanged<bool> onEmailChanged;
  final ValueChanged<bool> onPushChanged;

  const SettingsNotificationsSection({
    super.key,
    required this.notificationsEnabled,
    required this.emailNotificationsEnabled,
    required this.pushNotificationsEnabled,
    required this.onNotificationsChanged,
    required this.onEmailChanged,
    required this.onPushChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingsSectionTitle(
          title: 'Уведомления',
          icon: Icons.notifications_none,
        ),
        SettingsCard(
          children: [
            SettingsToggleRow(
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
            SettingsToggleRow(
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
            SettingsToggleRow(
              title: 'Push уведомления',
              subtitle: 'Получать push-уведомления на устройство',
              value: pushNotificationsEnabled,
              onChanged: onPushChanged,
            ),
          ],
        ),
      ],
    );
  }
}
