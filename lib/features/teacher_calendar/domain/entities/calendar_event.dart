class CalendarEventEntity {
  final String time;
  final String title;
  final String location;
  final String? description;

  const CalendarEventEntity({
    required this.time,
    required this.title,
    required this.location,
    this.description,
  });

  @override
  String toString() {
    return 'CalendarEvent{time: $time, title: $title, location: $location, description: $description}';
  }
}
