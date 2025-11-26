import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';

abstract class ScheduleState {
  const ScheduleState();
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class StudentGroupLoading extends ScheduleState {}

class SchedulesLoaded extends ScheduleState {
  final List<ScheduleResponseModel> schedules;

  const SchedulesLoaded(this.schedules);
}

class StudentGroupLoaded extends ScheduleState {
  final StudentGroupResponseModel group;

  const StudentGroupLoaded(this.group);
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

class StudentGroupError extends ScheduleState {
  final String message;

  const StudentGroupError(this.message);
}

class AttendanceOperationSuccess extends ScheduleState {
  final String message;

  const AttendanceOperationSuccess(this.message);
}

class AttendanceError extends ScheduleState {
  final String message;

  const AttendanceError(this.message);
}
