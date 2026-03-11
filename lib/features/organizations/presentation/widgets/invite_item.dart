import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class InviteItem extends StatelessWidget {
  final String organizationName;
  final String role;
  final String email;
  final String createdAt;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const InviteItem({
    super.key,
    required this.organizationName,
    required this.role,
    required this.email,
    required this.createdAt,
    required this.onAccept,
    required this.onDecline,
  });

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr).toLocal();
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? AppColors.darkSurface : AppColors.directoryBorder,
        ),
      ),
      child: Row(
        children: [
          // Иконка
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.plusButton.withAlpha(40)
                  : AppColors.plusButton.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.mail_outline,
              size: 20,
              color: isDark ? AppColors.darkText : AppColors.plusButton,
            ),
          ),
          const SizedBox(width: 12),

          // Основная информация
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
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: AppTextStyles.ttNorms12W400.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.directoryTextSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.plusButton.withAlpha(40)
                            : AppColors.plusButton.withAlpha(25),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        role,
                        style: AppTextStyles.ttNorms11W600.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.plusButton,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.access_time,
                      size: 11,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.directoryTextSecondary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      _formatDate(createdAt),
                      style: AppTextStyles.ttNorms11W400.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.directoryTextSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Кнопки
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: onDecline,
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: isDark
                        ? AppColors.darkCategoryGeneralText
                        : Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: onAccept,
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 18,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
