class CalendarEventEntity {
  final String time;
  final String title;
  final String location;
  final String? description;
  final bool isCompleted;

  const CalendarEventEntity({
    required this.time,
    required this.title,
    required this.location,
    this.description,
    required this.isCompleted,
  });

  factory CalendarEventEntity.fromSchedule({
    required String time,
    required String title,
    required String location,
    String? description,
    required bool isCompleted,
  }) {
    return CalendarEventEntity(
      time: time,
      title: title,
      location: location,
      description: description,
      isCompleted: isCompleted,
    );
  }

  @override
  String toString() {
    return 'CalendarEventEntity{time: $time, title: $title, location: $location, description: $description, isCompleted: $isCompleted}';
  }
}
