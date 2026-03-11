import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

class StudentItem extends StatefulWidget {
  final StudentEntity student;
  final String groupName;
  final VoidCallback onTap;

  const StudentItem({
    super.key,
    required this.student,
    required this.groupName,
    required this.onTap,
  });

  @override
  State<StudentItem> createState() => _StudentItemState();
}

class _StudentItemState extends State<StudentItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color getBackgroundColor() {
      if (_isPressed) {
        return isDark ? AppColors.darkEventTap : AppColors.eventTap;
      }
      return isDark ? AppColors.darkCard : AppColors.white;
    }

    Color getBorderColor() {
      if (_isPressed) {
        return isDark ? AppColors.darkEventTap : AppColors.eventTap;
      }
      return isDark ? AppColors.darkSurface : AppColors.directoryBorder;
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          border: Border.all(color: getBorderColor()),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Аватарка
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkCard
                    : AppColors.directoryAvatarBackground,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: isDark
                      ? AppColors.darkSurface
                      : AppColors.directoryAvatarBorder,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.person,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.directoryTextSecondary,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            // Имя и группа
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.student.name ?? ''} ${widget.student.surname ?? ''}',
                    style: AppTextStyles.arial14W700.copyWith(
                      color: isDark
                          ? AppColors.darkText
                          : AppColors.grayFieldText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Группа: ${widget.groupName}',
                    style: AppTextStyles.arial12W400.copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.directoryTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Стрелочка
            Image.asset(
              'assets/images/purple_arrow.png',
              width: 24,
              height: 24,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.grayFieldText,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.arrow_forward_ios,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.grayFieldText,
                  size: 20,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
