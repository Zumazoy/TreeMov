import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/shared/domain/entities/lesson_entity.dart';

class LessonItem extends StatelessWidget {
  final LessonEntity lesson;

  const LessonItem({super.key, required this.lesson});

  String _formatTeacherName() {
    if (lesson.teacher?.employee?.name == null &&
        lesson.teacher?.employee?.surname == null) {
      return 'Преподаватель';
    }

    final parts = [
      lesson.teacher?.employee!.surname,
      lesson.teacher?.employee!.name,
    ].where((part) => part != null && part.isNotEmpty).toList();

    if (parts.isEmpty) return 'Преподаватель';

    String teacherName = parts.join(' ');

    if (lesson.teacher?.employee!.patronymic != null &&
        lesson.teacher!.employee!.patronymic!.isNotEmpty) {
      teacherName += ' ${lesson.teacher!.employee!.patronymic![0]}.';
    }

    return teacherName;
  }

  @override
  Widget build(BuildContext context) {
    final startTime = lesson.startTime?.substring(0, 5) ?? '--:--';
    final endTime = lesson.endTime?.substring(0, 5) ?? '--:--';
    final teacherName = _formatTeacherName();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              startTime,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: AppColors.kidButton,
                fontFamily: 'TT Norms',
              ),
            ),
            Text(
              endTime,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: AppColors.kidButton,
                fontFamily: 'TT Norms',
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          width: 2,
          height: 30,
          color: AppColors.kidButton,
          margin: const EdgeInsets.only(top: 2),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${lesson.subject?.title ?? 'Занятие'} ($teacherName)',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.kidButton,
                  fontFamily: 'TT Norms',
                ),
              ),
              Text(
                lesson.classroom?.title ?? 'Аудитория',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kidButton,
                  fontFamily: 'TT Norms',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
