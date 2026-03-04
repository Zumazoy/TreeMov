part of 'kid_calendar_bloc.dart';

abstract class KidCalendarEvent extends Equatable {
  const KidCalendarEvent();

  @override
  List<Object?> get props => [];
}

class LoadKidLessonsEvent extends KidCalendarEvent {
  final String? dateMin;
  final String? dateMax;
  const LoadKidLessonsEvent({this.dateMin, this.dateMax});

  @override
  List<Object?> get props => [dateMin, dateMax];
}

class LessonsLoadedEvent extends KidCalendarEvent {
  final List<LessonEntity> lessons;

  const LessonsLoadedEvent(this.lessons);

  @override
  List<Object?> get props => [lessons];
}

class ChangeMonthEvent extends KidCalendarEvent {
  final int offset;

  const ChangeMonthEvent({required this.offset});

  @override
  List<Object?> get props => [offset];
}

class SelectDayEvent extends KidCalendarEvent {
  final int day;
  final DateTime selectedDate;

  const SelectDayEvent({required this.day, required this.selectedDate});

  @override
  List<Object?> get props => [day, selectedDate];
}

class ClosePanelEvent extends KidCalendarEvent {
  const ClosePanelEvent();
}
