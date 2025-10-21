import 'package:equatable/equatable.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/schedule_update_model.dart';

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

class CreateScheduleEvent extends ScheduleEvent {
  final ScheduleRequestModel request;

  const CreateScheduleEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class UpdateScheduleEvent extends ScheduleEvent {
  final int scheduleId;
  final ScheduleUpdateModel updateData;

  const UpdateScheduleEvent({
    required this.scheduleId,
    required this.updateData,
  });

  @override
  List<Object?> get props => [scheduleId, updateData];
}
