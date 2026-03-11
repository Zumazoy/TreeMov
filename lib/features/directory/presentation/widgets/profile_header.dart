import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

class ProfileHeader extends StatelessWidget {
  final StudentEntity student;
  final String groupName;

  const ProfileHeader({
    super.key,
    required this.student,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.eventTap,
        border: Border.all(
          color: isDark ? AppColors.darkSurface : AppColors.eventTap,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${student.name} ${student.surname}',
                  style: AppTextStyles.arial18W900.copyWith(
                    color: isDark
                        ? AppColors.darkText
                        : AppColors.grayFieldText,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Группа: ',
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: groupName,
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.grayFieldText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Почта: ',
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        //text: student.email ?? 'Не указана'
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.grayFieldText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Дата присоединения к группе: ',
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: 'Не указана', // Заглушка
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.grayFieldText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Аватарка
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkCard
                  : AppColors.directoryAvatarBackground,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: isDark
                    ? AppColors.darkSurface
                    : AppColors.directoryAvatarBorder,
                width: 4,
              ),
            ),
            child: Icon(
              Icons.person,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.directoryTextSecondary,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
