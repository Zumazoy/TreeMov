import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class SettingsMenu extends StatelessWidget {
  final VoidCallback onEditData;
  final VoidCallback onChangePassword;
  final VoidCallback onSettings;
  final VoidCallback onLogout;

  const SettingsMenu({
    super.key,
    required this.onEditData,
    required this.onChangePassword,
    required this.onSettings,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(
            'Редактировать данные',
            onEditData,
            icon: Image.asset(
              'assets/images/note_change_icon.png',
              width: 16,
              height: 16,
              color: AppColors.notesDarkText,
            ),
          ),
          _buildDivider(),
          _buildMenuItem(
            'Сменить пароль',
            onChangePassword,
            icon: Image.asset(
              'assets/images/lock_icon.png',
              width: 16,
              height: 16,
              color: AppColors.notesDarkText,
            ),
          ),
          _buildDivider(),
          _buildMenuItem(
            'Настройки',
            onSettings,
            icon: Image.asset(
              'assets/images/gear_icon.png',
              width: 16,
              height: 16,
              color: AppColors.notesDarkText,
            ),
          ),
          _buildDivider(),
          _buildMenuItem(
            'Выйти',
            onLogout,
            isLogout: true,
            icon: Image.asset(
              'assets/images/exit_icon.png',
              width: 16,
              height: 16,
              color: Colors.red,
            ),
            centered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    String text,
    VoidCallback onTap, {
    Widget? icon,
    bool isLogout = false,
    bool centered = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: centered
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon, const SizedBox(width: 8)],
                    Text(
                      text,
                      style: AppTextStyles.arial14W400.copyWith(
                        color: isLogout ? Colors.red : AppColors.notesDarkText,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    if (icon != null) ...[icon, const SizedBox(width: 8)],
                    Expanded(
                      child: Text(
                        text,
                        style: AppTextStyles.arial14W400.copyWith(
                          color: isLogout
                              ? Colors.red
                              : AppColors.notesDarkText,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 1,
      color: AppColors.notesDarkText,
    );
  }
}
