class DailyScheduleEntity {
  final int totalLessons;
  final NextLesson? nextLesson;
  final List<Reminder> reminders;

  DailyScheduleEntity({
    required this.totalLessons,
    this.nextLesson,
    required this.reminders,
  });
}

class NextLesson {
  final String group;
  final String time;
  final bool isCompleted;

  NextLesson({
    required this.group,
    required this.time,
    required this.isCompleted,
  });
}

class Reminder {
  final String text;
  final String time;
  final bool isCompleted;

  Reminder({required this.text, required this.time, required this.isCompleted});
}
