part of 'directory_bloc.dart';

abstract class DirectoryState extends Equatable {
  const DirectoryState();

  @override
  List<Object> get props => [];
}

class DirectoryInitial extends DirectoryState {}

class DirectoryLoading extends DirectoryState {}

class StudentsLoading extends DirectoryState {}

class GroupsLoaded extends DirectoryState {
  final List<GroupStudentsResponseModel> groups;

  const GroupsLoaded({required this.groups});

  @override
  List<Object> get props => [groups];
}

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

class StudentsInGroupLoaded extends DirectoryState {
  final List<StudentGroupMemberResponseModel> students;
  final int groupId;

  const StudentsInGroupLoaded({required this.students, required this.groupId});

  @override
  List<Object> get props => [students, groupId];
}

class DirectoryError extends DirectoryState {
  final String message;

  const DirectoryError(this.message);

  @override
  List<Object> get props => [message];
}
