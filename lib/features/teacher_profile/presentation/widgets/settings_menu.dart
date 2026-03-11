import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);

    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMenuItem(
            context,
            'Редактировать данные',
            onEditData,
            icon: Image.asset(
              'assets/images/note_change_icon.png',
              width: 16,
              height: 16,
              color: theme.iconTheme.color,
            ),
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            'Сменить пароль',
            onChangePassword,
            icon: Image.asset(
              'assets/images/lock_icon.png',
              width: 16,
              height: 16,
              color: theme.iconTheme.color,
            ),
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            'Настройки',
            onSettings,
            icon: Image.asset(
              'assets/images/gear_icon.png',
              width: 16,
              height: 16,
              color: theme.iconTheme.color,
            ),
          ),
          _buildDivider(context),
          _buildMenuItem(
            context,
            'Выйти',
            onLogout,
            isLogout: true,
            icon: Image.asset(
              'assets/images/exit_icon.png',
              width: 16,
              height: 16,
              color: theme.colorScheme.error,
            ),
            centered: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String text,
    VoidCallback onTap, {
    Widget? icon,
    bool isLogout = false,
    bool centered = false,
  }) {
    final theme = Theme.of(context);

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
                        color: isLogout
                            ? theme.colorScheme.error
                            : theme.textTheme.bodyMedium?.color,
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
                              ? theme.colorScheme.error
                              : theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 1,
      color: theme.dividerColor,
    );
  }
}
