class CalendarEvent {
  final String time;
  final String title;
  final String location;
  final String? description;
  final bool isCompleted;

  const CalendarEvent({
    required this.time,
    required this.title,
    required this.location,
    this.description,
    required this.isCompleted,
  });

  factory CalendarEvent.fromSchedule({
    required String time,
    required String title,
    required String location,
    String? description,
    required bool isCompleted,
  }) {
    return CalendarEvent(
      time: time,
      title: title,
      location: location,
      description: description,
      isCompleted: isCompleted,
    );
  }

  @override
  String toString() {
    return 'CalendarEvent{time: $time, title: $title, location: $location, description: $description, isCompleted: $isCompleted}';
  }
}
