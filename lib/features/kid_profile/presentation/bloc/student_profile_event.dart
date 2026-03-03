part of 'student_profile_bloc.dart';

abstract class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadStudentProfile extends StudentProfileEvent {}

class LoadStudentActivities extends StudentProfileEvent {}
