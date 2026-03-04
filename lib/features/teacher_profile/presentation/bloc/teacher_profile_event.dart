part of 'teacher_profile_bloc.dart';

abstract class TeacherProfileEvent extends Equatable {
  const TeacherProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadTeacherProfile extends TeacherProfileEvent {}

class LoadLessons extends TeacherProfileEvent {
  final DateTime dateMin;
  final DateTime dateMax;

  const LoadLessons(this.dateMin, this.dateMax);

  @override
  List<Object?> get props => [];
}
