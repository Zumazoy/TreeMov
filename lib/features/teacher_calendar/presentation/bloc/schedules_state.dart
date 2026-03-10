import 'package:treemov/features/teacher_calendar/data/models/attendance_response_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/student_group_member_response_model.dart';

abstract class ScheduleState {
  const ScheduleState();
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class AttendanceLoading extends ScheduleState {}

class LessonsLoaded extends ScheduleState {
  final List<LessonResponseModel> lessons;

  const LessonsLoaded(this.lessons);
}

class AttendanceLoaded extends ScheduleState {
  final List<AttendanceResponseModel> attendance;

  const AttendanceLoaded(this.attendance);
}

class StudentGroupLoaded extends ScheduleState {
  final List<StudentInGroupResponseModel> studentsInGroup;

  const StudentGroupLoaded(this.studentsInGroup);
}

class LessonOperationSuccess extends ScheduleState {
  final String message;

  const LessonOperationSuccess(this.message);
}

class LessonError extends ScheduleState {
  final String message;

  const LessonError(this.message);
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
