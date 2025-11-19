import 'package:equatable/equatable.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_schedule_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_request_model.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

class LoadSchedulesEvent extends ScheduleEvent {
  const LoadSchedulesEvent();

  @override
  List<Object?> get props => [];
}

class LoadScheduleByIdEvent extends ScheduleEvent {
  final int scheduleId;

  const LoadScheduleByIdEvent(this.scheduleId);

  @override
  List<Object?> get props => [scheduleId];
}

class LoadStudentGroupByIdEvent extends ScheduleEvent {
  final int groupId;

  const LoadStudentGroupByIdEvent(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

class CreateScheduleEvent extends ScheduleEvent {
  final ScheduleRequestModel request;

  const CreateScheduleEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class CreatePeriodScheduleEvent extends ScheduleEvent {
  final PeriodScheduleRequestModel request;

  const CreatePeriodScheduleEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class CreateMassAttendanceEvent extends ScheduleEvent {
  final List<AttendanceRequestModel> requests;

  const CreateMassAttendanceEvent(this.requests);

  @override
  List<Object?> get props => [requests];
}

// class UpdateScheduleEvent extends ScheduleEvent {
//   final int scheduleId;
//   final ScheduleUpdateModel updateData;

//   const UpdateScheduleEvent({
//     required this.scheduleId,
//     required this.updateData,
//   });

//   @override
//   List<Object?> get props => [scheduleId, updateData];
// }
