part of 'directory_bloc.dart';

abstract class DirectoryState extends Equatable {
  const DirectoryState();

  @override
  List<Object> get props => [];
}

class DirectoryInitial extends DirectoryState {}

class DirectoryLoading extends DirectoryState {}

class GroupsWithCountsLoaded extends DirectoryState {
  final List<GroupStudentsResponseModel> groups;
  final Map<int, int> groupStudentCounts;
  final Map<int, List<StudentGroupMemberResponseModel>> groupStudents;

  const GroupsWithCountsLoaded({
    required this.groups,
    required this.groupStudentCounts,
    required this.groupStudents,
  });

  @override
  List<Object> get props => [groups, groupStudentCounts, groupStudents];
}

class DirectoryError extends DirectoryState {
  final String message;

  const DirectoryError(this.message);

  @override
  List<Object> get props => [message];
}
