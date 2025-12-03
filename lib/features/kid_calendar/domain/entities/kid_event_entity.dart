class KidEventEntity {
  final int day; // число месяца
  final String startTime; // "18:30"
  final String endTime; // "20:00"
  final String title;
  final String teacher;
  final String room;

  const KidEventEntity({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.teacher,
    required this.room,
  });
}
