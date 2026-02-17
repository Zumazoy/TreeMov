import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';

class CalendarUtils {
  static List<DateTime?> generateMonthDays(DateTime currentDate) {
    final List<DateTime?> days = [];
    final firstDay = DateTime(currentDate.year, currentDate.month, 1);
    final lastDay = DateTime(currentDate.year, currentDate.month + 1, 0);

    int firstWeekdayIndex = firstDay.weekday - 1;

    // Добавляем пустые ячейки
    for (int i = 0; i < firstWeekdayIndex; i++) {
      days.add(null);
    }

    // Добавляем дни месяца
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(currentDate.year, currentDate.month, i));
    }

    return days;
  }

  /// Расчет высоты календаря
  static double calculateCalendarHeight(DateTime currentDate) {
    final firstDay = DateTime(currentDate.year, currentDate.month, 1);
    final lastDay = DateTime(currentDate.year, currentDate.month + 1, 0);

    int firstWeekdayIndex = firstDay.weekday - 1;

    final totalCells = lastDay.day + firstWeekdayIndex;
    final weeks = (totalCells / 7).ceil();

    return weeks * 56.0;
  }

  static String getMonthYearText(DateTime date) {
    const months = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  static Map<String, List<LessonEntity>> groupLessonsByDate(
    List<LessonResponseModel> lessons,
  ) {
    final Map<String, List<LessonEntity>> groupedEvents = {};

    for (final lesson in lessons) {
      String dateKey;
      try {
        final date = DateTime.parse(lesson.date!);
        dateKey = formatDateKey(date);
      } catch (e) {
        dateKey = lesson.date!;
      }

      if (!groupedEvents.containsKey(dateKey)) {
        groupedEvents[dateKey] = [];
      }

      groupedEvents[dateKey]!.add(
        LessonEntity(
          id: lesson.id,
          title: lesson.title,
          startTime: lesson.startTime,
          endTime: lesson.endTime,
          date: lesson.date,
          weekDay: lesson.weekDay,
          isCanceled: lesson.isCanceled,
          isCompleted: lesson.isCompleted,
          duration: lesson.duration,
          comment: lesson.comment,
          teacher: lesson.teacher,
          classroom: lesson.classroom,
          group: lesson.group,
          subject: lesson.subject,
        ),
      );
    }
    return groupedEvents;
  }

  static String formatDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Проверка на "сегодня"
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
