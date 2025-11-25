import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

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
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.teacherPrimary : Colors.transparent,
            border: Border.all(
              color: isCompleted ? AppColors.teacherPrimary : AppColors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: isCompleted
              ? Icon(Icons.check, size: 14, color: AppColors.white)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Arial',
              color: AppColors.notesDarkText,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ],
    );
  }
}
