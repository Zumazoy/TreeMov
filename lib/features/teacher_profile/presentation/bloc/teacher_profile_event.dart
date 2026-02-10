part of 'teacher_profile_bloc.dart';

abstract class TeacherProfileEvent extends Equatable {
  const TeacherProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadTeacherProfile extends TeacherProfileEvent {}

class LoadLessons extends TeacherProfileEvent {}
