import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_text_styles.dart';
import 'package:treemov/shared/domain/entities/lesson_entity.dart';

class LessonEventCard extends StatelessWidget {
  final LessonEntity event;
  final VoidCallback onTap;

  const LessonEventCard({super.key, required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 👈 ПОЛУЧАЕМ ТЕМУ

    final timeParts = event
        .formatTime(event.startTime, event.endTime)
        .split('\n');
    final startTime = timeParts.isNotEmpty ? timeParts[0] : '';
    final endTime = timeParts.length > 1 ? timeParts[1] : '';

    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardColor.withAlpha(
          26,
        ), // 👈 ИСПРАВЛЕНО (было AppColors.eventTap)
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  startTime,
                  style: AppTextStyles.ttNorms14W600.themed(
                    context,
                  ), // 👈 ИСПРАВЛЕНО
                ),
                const SizedBox(height: 4),
                Text(
                  endTime,
                  style: AppTextStyles.ttNorms12W400.themed(
                    context,
                  ), // 👈 ИСПРАВЛЕНО
                ),
              ],
            ),
          ),
          Container(
            width: 2,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color:
                  theme.dividerColor, // 👈 ИСПРАВЛЕНО (было Color(0xFF2F213E))
              borderRadius: BorderRadius.circular(4.5),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.formatLessonTitle(
                      event.title,
                      event.subject?.title,
                      event.group?.title,
                    ),
                    style: AppTextStyles.ttNorms14W500.themed(
                      context,
                    ), // 👈 ИСПРАВЛЕНО
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.classroom != null
                        ? event.formatTitle(event.classroom?.title)
                        : '(Не указана)',
                    style: AppTextStyles.ttNorms12W400.copyWith(
                      color: theme.textTheme.bodySmall?.color, // 👈 ИСПРАВЛЕНО
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset(
                'assets/images/purple_arrow.png',
                width: 24,
                height: 24,
                color:
                    theme.colorScheme.primary, // 👈 ИСПРАВЛЕНО (цвет стрелки)
                fit: BoxFit.contain,
              ),
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
