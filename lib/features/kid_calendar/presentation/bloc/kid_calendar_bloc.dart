import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/features/kid_calendar/domain/repositories/kid_calendar_repository.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';

part 'kid_calendar_event.dart';
part 'kid_calendar_state.dart';

class KidCalendarBloc extends Bloc<KidCalendarEvent, KidCalendarState> {
  final KidCalendarRepository _repository;

  KidCalendarBloc({required KidCalendarRepository repository})
    : _repository = repository,
      super(KidCalendarInitial()) {
    on<LoadKidLessonsEvent>(_onLoadLessons);
    on<ChangeMonthEvent>(_onChangeMonth);
    on<SelectDayEvent>(_onSelectDay);
    on<ClosePanelEvent>(_onClosePanel);
  }

  Future<void> _onLoadLessons(
    LoadKidLessonsEvent event,
    Emitter<KidCalendarState> emit,
  ) async {
    emit(KidCalendarLoading());
    try {
      final lessons = await _repository.getLessons(
        event.dateMin,
        event.dateMax,
      );

      final currentDate = _getCurrentDate(event.dateMin);
      final processed = _processLessons(lessons, currentDate);

      emit(
        KidCalendarLoaded(
          currentDate: currentDate,
          selectedDate: null,
          selectedDay: -1,
          daysWithLessons: processed.days,
          lessonsByDay: processed.lessonsByDay,
          allLessons: lessons,
        ),
      );
    } catch (e) {
      emit(KidCalendarError('Ошибка загрузки расписания: $e'));
    }
  }

  void _onChangeMonth(ChangeMonthEvent event, Emitter<KidCalendarState> emit) {
    if (state is KidCalendarLoaded) {
      final current = state as KidCalendarLoaded;
      final newDate = DateTime(
        current.currentDate.year,
        current.currentDate.month + event.offset,
        1,
      );

      final dateMin = _getFirstDayOfMonth(newDate);
      final dateMax = _getLastDayOfMonth(newDate);

      add(LoadKidLessonsEvent(dateMin, dateMax));
    }
  }

  void _onSelectDay(SelectDayEvent event, Emitter<KidCalendarState> emit) {
    if (state is KidCalendarLoaded) {
      final current = state as KidCalendarLoaded;
      emit(
        current.copyWith(
          selectedDate: event.selectedDate,
          selectedDay: event.day,
        ),
      );
    }
  }

  void _onClosePanel(ClosePanelEvent event, Emitter<KidCalendarState> emit) {
    if (state is KidCalendarLoaded) {
      final current = state as KidCalendarLoaded;
      emit(current.copyWith(selectedDate: null, selectedDay: -1));
    }
  }

  DateTime _getCurrentDate(String? dateMin) {
    if (dateMin != null) {
      try {
        return DateTime.parse(dateMin);
      } catch (_) {}
    }
    return DateTime.now();
  }

  String _getFirstDayOfMonth(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      1,
    ).toIso8601String().split('T').first;
  }

  String _getLastDayOfMonth(DateTime date) {
    return DateTime(
      date.year,
      date.month + 1,
      0,
    ).toIso8601String().split('T').first;
  }

  _ProcessedLessons _processLessons(
    List<LessonEntity> lessons,
    DateTime currentDate,
  ) {
    final Set<int> days = {};
    final Map<int, List<LessonEntity>> lessonsByDay = {};

    for (final lesson in lessons) {
      if (lesson.date != null) {
        try {
          final date = DateTime.parse(lesson.date!);
          if (date.year == currentDate.year &&
              date.month == currentDate.month) {
            days.add(date.day);
            if (!lessonsByDay.containsKey(date.day)) {
              lessonsByDay[date.day] = [];
            }
            lessonsByDay[date.day]!.add(lesson);
          }
        } catch (e) {
          continue;
        }
      }
    }

    return _ProcessedLessons(days: days, lessonsByDay: lessonsByDay);
  }
}

class _ProcessedLessons {
  final Set<int> days;
  final Map<int, List<LessonEntity>> lessonsByDay;

  _ProcessedLessons({required this.days, required this.lessonsByDay});
}
