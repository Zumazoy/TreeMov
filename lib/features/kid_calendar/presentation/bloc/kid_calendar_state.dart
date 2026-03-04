part of 'kid_calendar_bloc.dart';

abstract class KidCalendarState extends Equatable {
  const KidCalendarState();

  @override
  List<Object?> get props => [];
}

class KidCalendarInitial extends KidCalendarState {}

class KidCalendarLoading extends KidCalendarState {}

class KidCalendarLoaded extends KidCalendarState {
  final DateTime currentDate;
  final DateTime? selectedDate;
  final int selectedDay;
  final Set<int> daysWithLessons;
  final Map<int, List<LessonEntity>> lessonsByDay;
  final List<LessonEntity> allLessons;

  const KidCalendarLoaded({
    required this.currentDate,
    this.selectedDate,
    required this.selectedDay,
    required this.daysWithLessons,
    required this.lessonsByDay,
    required this.allLessons,
  });

  @override
  List<Object?> get props => [
    currentDate,
    selectedDate,
    selectedDay,
    daysWithLessons,
    lessonsByDay,
    allLessons,
  ];

  KidCalendarLoaded copyWith({
    DateTime? currentDate,
    DateTime? selectedDate,
    int? selectedDay,
    Set<int>? daysWithLessons,
    Map<int, List<LessonEntity>>? lessonsByDay,
    List<LessonEntity>? allLessons,
  }) {
    return KidCalendarLoaded(
      currentDate: currentDate ?? this.currentDate,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedDay: selectedDay ?? this.selectedDay,
      daysWithLessons: daysWithLessons ?? this.daysWithLessons,
      lessonsByDay: lessonsByDay ?? this.lessonsByDay,
      allLessons: allLessons ?? this.allLessons,
    );
  }
}

class KidCalendarError extends KidCalendarState {
  final String message;

  const KidCalendarError(this.message);

  @override
  List<Object?> get props => [message];
}
