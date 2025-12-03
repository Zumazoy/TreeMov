abstract class KidCalendarEvent {}

class LoadKidCalendar extends KidCalendarEvent {
  final int? kidId;
  LoadKidCalendar({this.kidId});
}

class SelectKidDay extends KidCalendarEvent {
  final int day;
  SelectKidDay(this.day);
}
