class CalendarEvent {
  final String time;
  final String title;
  final String location;

  const CalendarEvent({
    required this.time,
    required this.title,
    required this.location,
  });

  @override
  String toString() {
    return 'CalendarEvent{time: $time, title: $title, location: $location}';
  }
}