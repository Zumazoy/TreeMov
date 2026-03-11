import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class OrganizationItem extends StatelessWidget {
  final String organizationName;
  final String userRole;
  final Color avatarColor;
  final VoidCallback onTap;

  const OrganizationItem({
    super.key,
    required this.organizationName,
    required this.userRole,
    required this.avatarColor,
    required this.onTap,
  });

  Color _getRoleColor(String role, bool isDark) {
    if (role.toLowerCase().contains('администратор') ||
        role.toLowerCase().contains('crm_admin') ||
        role.toLowerCase().contains('teacher') ||
        role.toLowerCase().contains('учитель')) {
      return isDark ? AppColors.darkCategoryParentsText : AppColors.plusButton;
    } else if (role.toLowerCase().contains('студент') ||
        role.toLowerCase().contains('student') ||
        role.toLowerCase().contains('ученик')) {
      return isDark
          ? AppColors.darkCategoryStudyText
          : AppColors.calendarButton;
    }
    return isDark
        ? AppColors.darkTextSecondary
        : AppColors.directoryTextSecondary;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final roleColor = _getRoleColor(userRole, isDark);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark
                    ? AppColors.darkSurface
                    : AppColors.directoryBorder,
              ),
            ),
            child: Row(
              children: [
                // Аватар с первой буквой
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark
                        ? avatarColor.withAlpha(40)
                        : avatarColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      organizationName.isNotEmpty
                          ? organizationName[0].toUpperCase()
                          : '?',
                      style: AppTextStyles.ttNorms20W700.copyWith(
                        color: isDark ? AppColors.darkText : avatarColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Название организации
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        organizationName,
                        style: AppTextStyles.ttNorms16W600.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.grayFieldText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? roleColor.withAlpha(40)
                              : roleColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          userRole,
                          style: AppTextStyles.ttNorms11W600.copyWith(
                            color: roleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Стрелка
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.directoryTextSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
