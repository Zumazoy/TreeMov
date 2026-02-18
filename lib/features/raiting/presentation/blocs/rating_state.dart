import 'package:treemov/shared/domain/entities/student_entity.dart';

abstract class RatingState {
  const RatingState();
}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class StudentsLoaded extends RatingState {
  final List<StudentEntity> students;

  const StudentsLoaded(this.students);
}

class CurrentStudentLoaded extends RatingState {
  final StudentEntity? currentStudent;

  const CurrentStudentLoaded(this.currentStudent);
}

class RatingError extends RatingState {
  final String message;

  const RatingError(this.message);
}
