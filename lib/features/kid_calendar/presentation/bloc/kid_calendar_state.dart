import 'package:equatable/equatable.dart';
import 'package:treemov/features/kid_calendar/domain/entities/kid_event_entity.dart';

class KidCalendarState extends Equatable {
  final bool isLoading;
  final List<KidEventEntity> events;
  final Set<int> lessonDays;
  final int? selectedDay;
  final String? error;

  const KidCalendarState({
    this.isLoading = false,
    this.events = const [],
    this.lessonDays = const {},
    this.selectedDay,
    this.error,
  });

  KidCalendarState copyWith({
    bool? isLoading,
    List<KidEventEntity>? events,
    Set<int>? lessonDays,
    int? selectedDay,
    String? error,
  }) => KidCalendarState(
    isLoading: isLoading ?? this.isLoading,
    events: events ?? this.events,
    lessonDays: lessonDays ?? this.lessonDays,
    selectedDay: selectedDay ?? this.selectedDay,
    error: error,
  );

  @override
  List<Object?> get props => [
    isLoading,
    events,
    lessonDays,
    selectedDay,
    error,
  ];
}
