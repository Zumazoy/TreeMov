import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';

abstract class ScheduleState {
  const ScheduleState();
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class SchedulesLoaded extends ScheduleState {
  final List<ScheduleResponseModel> schedules;

  const SchedulesLoaded(this.schedules);
}

class ScheduleLoaded extends ScheduleState {
  final ScheduleResponseModel schedule;

  const ScheduleLoaded(this.schedule);
}

class ScheduleOperationSuccess extends ScheduleState {
  final String message;

  const ScheduleOperationSuccess(this.message);
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError(this.message);
}
