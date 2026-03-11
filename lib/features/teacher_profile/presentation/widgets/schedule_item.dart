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
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isCompleted ? theme.colorScheme.primary : Colors.transparent,
            border: Border.all(
              color: isCompleted
                  ? theme.colorScheme.primary
                  : theme.dividerColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: isCompleted
              ? Icon(Icons.check, size: 14, color: theme.colorScheme.onPrimary)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.arial14W400
                .themed(context)
                .copyWith(
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
          ),
        ),
      ],
    );
  }
}
