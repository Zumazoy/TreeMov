import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

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

  Color _getRoleColor(String role) {
    if (role.toLowerCase().contains('администратор') ||
        role.toLowerCase().contains('crm_admin') ||
        role.toLowerCase().contains('teacher') ||
        role.toLowerCase().contains('учитель')) {
      return AppColors.plusButton;
    } else if (role.toLowerCase().contains('студент') ||
        role.toLowerCase().contains('student') ||
        role.toLowerCase().contains('ученик')) {
      return AppColors.calendarButton;
    }
    return AppColors.directoryTextSecondary;
  }

  @override
  Widget build(BuildContext context) {
    final roleColor = _getRoleColor(userRole);

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
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.directoryBorder),
            ),
            child: Row(
              children: [
                // Аватар с первой буквой
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: avatarColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      organizationName.isNotEmpty
                          ? organizationName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: avatarColor,
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
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayFieldText,
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
                          color: roleColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          userRole,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: roleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Стрелка
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: AppColors.directoryTextSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
