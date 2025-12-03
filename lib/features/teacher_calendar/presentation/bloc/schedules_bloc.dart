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
    on<LoadLessonByIdEvent>(_onLoadLessonById);
    on<LoadStudentGroupByIdEvent>(_onLoadStudentGroupById);
    on<CreateLessonEvent>(_onCreateLesson);
    on<CreatePeriodLessonEvent>(_onCreatePeriodLesson);
    on<CreateMassAttendanceEvent>(_onCreateMassAttendance);
    // on<UpdateScheduleEvent>(_onUpdateSchedule);
  }

  Future<void> _onLoadLessons(
    LoadLessonsEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final lessons = await _sharedRepository.getLessons();
      emit(LessonsLoaded(lessons));
    } catch (e) {
      emit(LessonError('Ошибка загрузки расписания: $e'));
    }
  }

  Future<void> _onLoadLessonById(
    LoadLessonByIdEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final lesson = await _scheduleRepository.getLessonById(event.lessonId);
      emit(LessonLoaded(lesson));
    } catch (e) {
      emit(LessonError('Ошибка загрузки занятия: $e'));
    }
  }

  Future<void> _onLoadStudentGroupById(
    LoadStudentGroupByIdEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(StudentGroupLoading());
    try {
      final group = await _sharedRepository.getStudentGroupById(event.groupId);
      emit(StudentGroupLoaded(group));
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
      add(LoadLessonsEvent());
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
      add(LoadLessonsEvent());
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
      // Отправляем все запросы последовательно
      for (final attendanceRequest in event.requests) {
        await _scheduleRepository.createAttendance(attendanceRequest);
      }
      emit(AttendanceOperationSuccess('Посещаемость успешно сохранена'));
    } catch (e) {
      emit(AttendanceError('Ошибка сохранения посещаемости: $e'));
    }
  }

  // Future<void> _onUpdateSchedule(
  //   UpdateScheduleEvent event,
  //   Emitter<ScheduleState> emit,
  // ) async {
  //   emit(ScheduleLoading());
  //   try {
  //     await _repository.updateSchedule(
  //       scheduleId: event.scheduleId,
  //       updateData: event.updateData,
  //     );
  //     emit(ScheduleOperationSuccess('Занятие успешно обновлено'));
  //   } catch (e) {
  //     emit(ScheduleError('Ошибка обновления занятия: $e'));
  //   }
  // }
}
