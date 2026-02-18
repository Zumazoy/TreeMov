part of 'accrual_bloc.dart';

abstract class AccrualState extends Equatable {
  const AccrualState();

  @override
  List<Object?> get props => [];
}

class AccrualInitial extends AccrualState {}

class AccrualLoading extends AccrualState {}

class AccrualCreating extends AccrualState {}

class GroupsLoaded extends AccrualState {
  final List<GroupStudentsResponseModel> groups;
  final Map<int, int> groupStudentCounts;
  final Map<int, List<dynamic>> groupStudents;

  const GroupsLoaded({
    required this.groups,
    required this.groupStudentCounts,
    required this.groupStudents,
  });

  @override
  List<Object?> get props => [groups, groupStudentCounts, groupStudents];
}

class TeacherProfileIdLoaded extends AccrualState {
  final int teacherProfileId;

  const TeacherProfileIdLoaded(this.teacherProfileId);

  @override
  List<Object?> get props => [teacherProfileId];
}

class AccrualCreated extends AccrualState {
  final String message;

  const AccrualCreated(this.message);

  @override
  List<Object?> get props => [message];
}

class AccrualError extends AccrualState {
  final String message;

  const AccrualError(this.message);

  @override
  List<Object?> get props => [message];
}
