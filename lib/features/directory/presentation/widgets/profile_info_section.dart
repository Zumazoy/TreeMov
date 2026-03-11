import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/features/directory/presentation/screens/student_directory.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

class ProfileInfoSection extends StatelessWidget {
  final StudentEntity student;
  final List<GroupStudentsResponseModel> allGroups;
  final String currentGroupName;

  const ProfileInfoSection({
    super.key,
    required this.student,
    required this.allGroups,
    required this.currentGroupName,
  });

  int _calculateAge(String? birthday) {
    if (birthday == null) return 0;
    try {
      final birthDate = DateTime.parse(birthday);
      final now = DateTime.now();
      int age = now.year - birthDate.year;
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }

  String _formatDate(String? date) {
    if (date == null) return 'Не указана';
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.day}.${dateTime.month}.${dateTime.year}';
    } catch (e) {
      return date;
    }
  }

  // Здесь нужно будет получать группы студента из отдельного API
  List<GroupStudentsResponseModel> _getOtherGroups() {
    return [];
  }

  void _onGroupTap(BuildContext context, GroupStudentsResponseModel group) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            StudentDirectoryScreen(group: group, allGroups: allGroups),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final age = _calculateAge(student.birthday);
    final otherGroups = _getOtherGroups();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.eventTap,
        border: Border.all(
          color: isDark ? AppColors.darkSurface : AppColors.eventTap,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'День рождения: ',
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: _formatDate(student.birthday),
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.grayFieldText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '$age лет',
                style: AppTextStyles.arial12W400.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.directoryTextSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Прогресс: ',
                  style: AppTextStyles.arial12W400.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.directoryTextSecondary,
                  ),
                ),
                TextSpan(
                  text: student.progress ?? 'Не указан',
                  style: AppTextStyles.arial12W400.copyWith(
                    color: isDark
                        ? AppColors.darkText
                        : AppColors.grayFieldText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Text(
            'Другие группы:',
            style: AppTextStyles.arial12W400.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.directoryTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          if (otherGroups.isEmpty)
            Text(
              'Нет других групп',
              style: AppTextStyles.arial12W400.copyWith(
                color: isDark ? AppColors.darkText : AppColors.grayFieldText,
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: otherGroups.map((group) {
                return GestureDetector(
                  onTap: () => _onGroupTap(context, group),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkSurface
                            : AppColors.directoryBorder,
                      ),
                    ),
                    child: Text(
                      group.title ?? 'Без названия',
                      style: AppTextStyles.arial12W400.copyWith(
                        color: isDark
                            ? AppColors.darkText
                            : AppColors.grayFieldText,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 12),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Email: ',
                  style: AppTextStyles.arial12W400.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.directoryTextSecondary,
                  ),
                ),
                TextSpan(
                  text: student.orgMember?.profile?.email ?? 'Не указан',
                  style: AppTextStyles.arial12W400.copyWith(
                    color: isDark
                        ? AppColors.darkText
                        : AppColors.grayFieldText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Text(
            'Контакты родителей:',
            style: AppTextStyles.arial12W400.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.directoryTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Не указаны',
            style: AppTextStyles.arial12W400.copyWith(
              color: isDark ? AppColors.darkText : AppColors.grayFieldText,
            ),
          ),
        ],
      ),
    );
  }
}
