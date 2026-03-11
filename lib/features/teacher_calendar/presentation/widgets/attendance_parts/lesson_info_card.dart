import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class LessonInfoCard extends StatelessWidget {
  final Map<String, dynamic> lesson;
  final double availableWidth;

  const LessonInfoCard({
    super.key,
    required this.lesson,
    required this.availableWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor = isDark ? AppColors.darkCard : AppColors.eventTap;
    final borderColor = isDark
        ? AppColors.darkSurface
        : AppColors.calendarButton;
    final primaryTextColor = isDark ? AppColors.darkText : Colors.black;
    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.grayFieldText;
    final iconColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.grayFieldText;

    return Container(
      width: availableWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.5),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Группа
          Text(
            lesson['group'],
            style: AppTextStyles.ttNorms18W700.copyWith(
              color: primaryTextColor,
            ),
          ),
          const SizedBox(height: 16),

          // Данные о занятии
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Левая колонка
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        icon: 'assets/images/activity_icon.png',
                        text: lesson['subject'],
                        iconColor: iconColor,
                        textColor: secondaryTextColor,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        icon: 'assets/images/clock_icon.png',
                        text: lesson['time'],
                        iconColor: iconColor,
                        textColor: secondaryTextColor,
                      ),
                    ],
                  ),
                ),

                // Правая колонка
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        icon: 'assets/images/place_icon.png',
                        text: lesson['classroom'],
                        iconColor: iconColor,
                        textColor: secondaryTextColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String icon,
    required String text,
    required Color iconColor,
    required Color textColor,
  }) {
    return Row(
      children: [
        Image.asset(icon, width: 16, height: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.ttNorms14W500.copyWith(color: textColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
