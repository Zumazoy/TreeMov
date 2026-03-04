import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class ScheduleItem extends StatelessWidget {
  final bool isCompleted;
  final String text;

  const ScheduleItem({
    super.key,
    required this.isCompleted,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 👈 ПОЛУЧАЕМ ТЕМУ

    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isCompleted
                ? theme
                      .colorScheme
                      .primary // 👈 ИСПРАВЛЕНО (было teacherPrimary)
                : Colors.transparent,
            border: Border.all(
              color: isCompleted
                  ? theme
                        .colorScheme
                        .primary // 👈 ИСПРАВЛЕНО
                  : theme.dividerColor, // 👈 ИСПРАВЛЕНО (было AppColors.grey)
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: isCompleted
              ? Icon(
                  Icons.check,
                  size: 14,
                  color: theme
                      .colorScheme
                      .onPrimary, // 👈 ИСПРАВЛЕНО (белый из темы)
                )
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.arial14W400
                .themed(context)
                .copyWith(
                  // 👈 ИСПРАВЛЕНО
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
          ),
        ),
      ],
    );
  }
}
