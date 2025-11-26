import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/daily_schedule_entity.dart';

class DailyScheduleCard extends StatelessWidget {
  final DailyScheduleEntity dailySchedule;

  const DailyScheduleCard({super.key, required this.dailySchedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.eventTap,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/grad_calendar.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Мой день',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        color: AppColors.notesDarkText,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildScheduleItem(
                  'assets/images/book_icon.png',
                  '${dailySchedule.totalLessons} занятия сегодня',
                  AppColors.statsTotalText,
                  isNumberColored: true,
                ),
                const SizedBox(height: 12),
                if (dailySchedule.nextLesson != null)
                  _buildScheduleItem(
                    'assets/images/clock_icon.png',
                    'Следующий: ${dailySchedule.nextLesson!.group} ${dailySchedule.nextLesson!.time}',
                    AppColors.statsPinnedText,
                    isTimeColored: true,
                  ),
                const SizedBox(height: 12),
                for (final reminder in dailySchedule.reminders)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildScheduleItem(
                      'assets/images/bell_icon.png',
                      'Напоминание: ${reminder.text} ${reminder.time}',
                      AppColors.categoryGeneralText,
                      isReminderColored: true,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            color: AppColors.teacherPrimary,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Нажмите для просмотра расписания',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF5853FF),
                    height: 1.0,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/purple_arrow.png',
                  width: 16,
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(
    String iconPath,
    String text,
    Color color, {
    bool isNumberColored = false,
    bool isTimeColored = false,
    bool isReminderColored = false,
  }) {
    return Row(
      children: [
        Image.asset(iconPath, width: 16, height: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: _buildColoredText(
            text,
            color,
            isNumberColored: isNumberColored,
            isTimeColored: isTimeColored,
            isReminderColored: isReminderColored,
          ),
        ),
      ],
    );
  }

  Widget _buildColoredText(
    String text,
    Color color, {
    bool isNumberColored = false,
    bool isTimeColored = false,
    bool isReminderColored = false,
  }) {
    if (isNumberColored) {
      final numberMatch = RegExp(r'\d+').firstMatch(text);
      if (numberMatch != null) {
        final number = numberMatch.group(0)!;
        final before = text.substring(0, numberMatch.start);
        final after = text.substring(numberMatch.end);

        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Arial',
              color: AppColors.notesDarkText,
            ),
            children: [
              TextSpan(text: before),
              TextSpan(
                text: number,
                style: TextStyle(color: color),
              ),
              TextSpan(text: after),
            ],
          ),
        );
      }
    } else if (isTimeColored) {
      final timeMatch = RegExp(r'\d{2}:\d{2}–\d{2}:\d{2}').firstMatch(text);
      if (timeMatch != null) {
        final time = timeMatch.group(0)!;
        final before = text.substring(0, timeMatch.start);
        final after = text.substring(timeMatch.end);

        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Arial',
              color: AppColors.notesDarkText,
            ),
            children: [
              TextSpan(text: before),
              TextSpan(
                text: time,
                style: TextStyle(color: color),
              ),
              TextSpan(text: after),
            ],
          ),
        );
      }
    } else if (isReminderColored) {
      final reminderMatch = RegExp(r'Напоминание: (.+)').firstMatch(text);
      if (reminderMatch != null && reminderMatch.groupCount >= 1) {
        final reminderText = reminderMatch.group(1)!;

        return RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Arial',
              color: AppColors.notesDarkText,
            ),
            children: [
              const TextSpan(text: 'Напоминание: '),
              TextSpan(
                text: reminderText,
                style: TextStyle(color: color),
              ),
            ],
          ),
        );
      }
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Arial',
        color: AppColors.notesDarkText,
      ),
    );
  }
}
