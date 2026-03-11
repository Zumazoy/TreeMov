import 'package:flutter/material.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_card.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_nav_row.dart';
import 'package:treemov/features/teacher_profile/presentation/widgets/settings_section_title.dart';

class SettingsSecuritySection extends StatelessWidget {
  final VoidCallback onChangePasswordTap;
  final VoidCallback onTwoFactorTap;

  const SettingsSecuritySection({
    super.key,
    required this.onChangePasswordTap,
    required this.onTwoFactorTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SettingsSectionTitle(
          title: 'Безопасность',
          icon: Icons.security_outlined,
        ),
        SettingsCard(
          children: [
            SettingsNavRow(
              title: 'Сменить пароль',
              subtitle: 'Изменить пароль для входа',
              onTap: onChangePasswordTap,
            ),
            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: theme.dividerColor,
            ),
            SettingsNavRow(
              title: 'Двухфакторная аутентификация',
              subtitle: 'Настроить дополнительную защиту',
              onTap: onTwoFactorTap,
            ),
          ],
        ),
      ],
    );
  }
}
