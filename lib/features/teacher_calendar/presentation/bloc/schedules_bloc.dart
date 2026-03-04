import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:treemov/features/teacher_calendar/domain/repositories/schedule_repository.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_event.dart';
import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_state.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

class SchedulesBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _scheduleRepository;
  final SharedRepository _sharedRepository;

  SchedulesBloc(this._scheduleRepository, this._sharedRepository)
    : super(ScheduleInitial()) {
    on<LoadLessonsEvent>(_onLoadLessons);
    on<LoadStudentsInGroupByIdEvent>(_onLoadStudentsInGroupById);
    on<CreateLessonEvent>(_onCreateLesson);
    on<CreatePeriodLessonEvent>(_onCreatePeriodLesson);
    on<CreateMassAttendanceEvent>(_onCreateMassAttendance);
  }

  Future<void> _onLoadLessons(
    LoadLessonsEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final lessons = await _sharedRepository.getLessons(
        event.dateMin,
        event.dateMax,
      );
      emit(LessonsLoaded(lessons));
    } catch (e) {
      emit(LessonError('Ошибка загрузки расписания: $e'));
    }
  }

  Future<void> _onLoadStudentsInGroupById(
    LoadStudentsInGroupByIdEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(StudentsLoading());
    try {
      final students = await _sharedRepository.getStudentsInGroup(
        event.groupId,
      );
      emit(StudentGroupLoaded(students));
    } catch (e) {
      emit(StudentGroupError('Ошибка загрузки группы: $e'));
    }
  }

  Future<void> _onCreateLesson(
    CreateLessonEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await _scheduleRepository.createLesson(event.request);
      emit(LessonOperationSuccess('Занятие успешно создано'));
    } catch (e) {
      emit(LessonError('Ошибка создания занятия: $e'));
    }
  }

  Future<void> _onCreatePeriodLesson(
    CreatePeriodLessonEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await _scheduleRepository.createPeriodLesson(event.request);
      emit(LessonOperationSuccess('Периодическое занятие успешно создано'));
    } catch (e) {
      emit(LessonError('Ошибка создания периодического занятия: $e'));
    }
  }

  Future<void> _onCreateMassAttendance(
    CreateMassAttendanceEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await _scheduleRepository.createMassAttendance(event.request);
      emit(AttendanceOperationSuccess('Посещаемость успешно сохранена'));
    } catch (e) {
      emit(AttendanceError('Ошибка сохранения посещаемости: $e'));
    }
  }
}
