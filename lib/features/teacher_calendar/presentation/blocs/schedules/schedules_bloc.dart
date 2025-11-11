import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:treemov/features/teacher_calendar/domain/repositories/schedule_repository.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_event.dart';
import 'package:treemov/features/teacher_calendar/presentation/blocs/schedules/schedules_state.dart';

class SchedulesBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _repository;

  SchedulesBloc(this._repository) : super(ScheduleInitial()) {
    on<LoadSchedulesEvent>(_onLoadSchedules);
    on<LoadScheduleByIdEvent>(_onLoadScheduleById);
    on<CreateScheduleEvent>(_onCreateSchedule);
    on<CreatePeriodScheduleEvent>(_onCreatePeriodSchedule);
    on<UpdateScheduleEvent>(_onUpdateSchedule);
  }

  Future<void> _onLoadSchedules(
    LoadSchedulesEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final schedules = await _repository.getAllSchedules();
      emit(SchedulesLoaded(schedules));
    } catch (e) {
      emit(ScheduleError('Ошибка загрузки расписания: $e'));
    }
  }

  Future<void> _onLoadScheduleById(
    LoadScheduleByIdEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final schedule = await _repository.getScheduleById(event.scheduleId);
      emit(ScheduleLoaded(schedule));
    } catch (e) {
      emit(ScheduleError('Ошибка загрузки занятия: $e'));
    }
  }

  Future<void> _onCreateSchedule(
    CreateScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await _repository.createSchedule(event.request);
      emit(ScheduleOperationSuccess('Занятие успешно создано'));
      add(LoadSchedulesEvent());
    } catch (e) {
      emit(ScheduleError('Ошибка создания занятия: $e'));
    }
  }

  Future<void> _onCreatePeriodSchedule(
    CreatePeriodScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await _repository.createPeriodSchedule(event.request);
      emit(ScheduleOperationSuccess('Периодическое занятие успешно создано'));
      add(LoadSchedulesEvent());
    } catch (e) {
      emit(ScheduleError('Ошибка создания периодического занятия: $e'));
    }
  }

  Future<void> _onUpdateSchedule(
    UpdateScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      await _repository.updateSchedule(
        scheduleId: event.scheduleId,
        updateData: event.updateData,
      );
      emit(ScheduleOperationSuccess('Занятие успешно обновлено'));
    } catch (e) {
      emit(ScheduleError('Ошибка обновления занятия: $e'));
    }
  }
}
