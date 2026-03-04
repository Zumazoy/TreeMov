import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_state.dart';

part 'kid_calendar_event.dart';
part 'kid_calendar_state.dart';

class KidCalendarBloc extends Bloc<KidCalendarEvent, KidCalendarState> {
  final SchedulesBloc schedulesBloc;
  late final StreamSubscription _schedulesSubscription;

  KidCalendarBloc({required this.schedulesBloc}) : super(KidCalendarInitial()) {
    // on<LoadKidLessonsEvent>(_onLoadLessons);
    on<LessonsLoadedEvent>(_onLessonsLoaded);
    on<ChangeMonthEvent>(_onChangeMonth);
    on<SelectDayEvent>(_onSelectDay);
    on<ClosePanelEvent>(_onClosePanel);

    _schedulesSubscription = schedulesBloc.stream.listen((state) {
      if (state is LessonsLoaded) {
        add(LessonsLoadedEvent(state.lessons as List<LessonEntity>));
      }
    });

    add(const LoadKidLessonsEvent());
  }

  // void _onLoadLessons(
  //   LoadKidLessonsEvent event,
  //   Emitter<KidCalendarState> emit,
  // ) {
  //   emit(KidCalendarLoading());
  //   schedulesBloc.add(const LoadLessonsEvent());
  // }

  void _onLessonsLoaded(
    LessonsLoadedEvent event,
    Emitter<KidCalendarState> emit,
  ) {
    final currentDate = _getCurrentDateFromState();
    final processed = _processLessons(event.lessons, currentDate);

    emit(
      KidCalendarLoaded(
        currentDate: currentDate,
        selectedDate: null,
        selectedDay: -1,
        daysWithLessons: processed.days,
        lessonsByDay: processed.lessonsByDay,
        allLessons: event.lessons,
      ),
    );
  }

  void _onChangeMonth(ChangeMonthEvent event, Emitter<KidCalendarState> emit) {
    if (state is KidCalendarLoaded) {
      final current = state as KidCalendarLoaded;
      final newDate = DateTime(
        current.currentDate.year,
        current.currentDate.month + event.offset,
        1,
      );

      final processed = _processLessons(current.allLessons, newDate);

      emit(
        current.copyWith(
          currentDate: newDate,
          selectedDate: null,
          selectedDay: -1,
          daysWithLessons: processed.days,
          lessonsByDay: processed.lessonsByDay,
        ),
      );
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

  DateTime _getCurrentDateFromState() {
    if (state is KidCalendarLoaded) {
      return (state as KidCalendarLoaded).currentDate;
    }
    return DateTime.now();
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

  @override
  Future<void> close() {
    _schedulesSubscription.cancel();
    return super.close();
  }
}

class _ProcessedLessons {
  final Set<int> days;
  final Map<int, List<LessonEntity>> lessonsByDay;

  _ProcessedLessons({required this.days, required this.lessonsByDay});
}
