import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/student_group_member_response_model.dart';

abstract class ScheduleState {
  const ScheduleState();
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class StudentsLoading extends ScheduleState {}

class LessonsLoaded extends ScheduleState {
  final List<LessonResponseModel> lessons;

  const LessonsLoaded(this.lessons);
}

class StudentGroupLoaded extends ScheduleState {
  final List<StudentInGroupResponseModel> studentsInGroup;

  const StudentGroupLoaded(this.studentsInGroup);
}

class LessonLoaded extends ScheduleState {
  final LessonResponseModel lesson;

  const LessonLoaded(this.lesson);
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
