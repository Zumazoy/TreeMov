import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_card.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_nav_row.dart';

class StudentSettingsSecuritySection extends StatelessWidget {
  final VoidCallback onChangePasswordTap;
  final VoidCallback onTwoFactorTap; // Новый параметр
  final VoidCallback onParentControlTap;
  final VoidCallback onPrivacyPolicyTap; // Новый параметр

  const StudentSettingsSecuritySection({
    super.key,
    required this.onChangePasswordTap,
    required this.onTwoFactorTap,
    required this.onParentControlTap,
    required this.onPrivacyPolicyTap,
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
              Icon(Icons.security_outlined, size: 24, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Безопасность',
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
              title: 'Изменить пароль',
              subtitle: 'Обновить пароль для входа',
              onTap: onChangePasswordTap,
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            StudentSettingsNavRow(
              title: 'Двухфакторная аутентификация',
              subtitle: 'Настроить дополнительную защиту',
              onTap: onTwoFactorTap,
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            StudentSettingsNavRow(
              title: 'Родительский контроль',
              subtitle: 'Настроить ограничения',
              onTap: onParentControlTap,
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            StudentSettingsNavRow(
              title: 'Политика конфиденциальности',
              subtitle: 'Ознакомиться с политикой обработки данных',
              onTap: onPrivacyPolicyTap,
            ),
          ],
        ),
      ],
    );
  }
}
