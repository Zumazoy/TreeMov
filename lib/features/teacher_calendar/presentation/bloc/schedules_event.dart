import 'package:equatable/equatable.dart';
import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_lesson_request_model.dart';
import 'package:treemov/shared/data/models/lesson_request_model.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

class LoadLessonsEvent extends ScheduleEvent {
  const LoadLessonsEvent();

  @override
  List<Object?> get props => [];
}

class LoadLessonByIdEvent extends ScheduleEvent {
  final int lessonId;

  const LoadLessonByIdEvent(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

class LoadStudentsInGroupByIdEvent extends ScheduleEvent {
  final int groupId;

  const LoadStudentsInGroupByIdEvent(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

class CreateLessonEvent extends ScheduleEvent {
  final LessonRequestModel request;

  const CreateLessonEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class CreatePeriodLessonEvent extends ScheduleEvent {
  final PeriodLessonRequestModel request;

  const CreatePeriodLessonEvent(this.request);

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
