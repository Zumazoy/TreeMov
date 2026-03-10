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
  final DateTime dateMin;
  final DateTime dateMax;

  const LoadLessonsEvent(this.dateMin, this.dateMax);

  @override
  List<Object?> get props => [dateMin, dateMax];
}

class LoadAttendanceEvent extends ScheduleEvent {
  final int groupId;
  final int lessonId;

  const LoadAttendanceEvent(this.groupId, this.lessonId);

  @override
  List<Object?> get props => [groupId, lessonId];
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
  final List<AttendanceRequestModel> request;

  const CreateMassAttendanceEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class PatchMassAttendanceEvent extends ScheduleEvent {
  final Map<int, AttendanceRequestModel> requests;

  const PatchMassAttendanceEvent(this.requests);

  @override
  List<Object?> get props => [requests];
}
