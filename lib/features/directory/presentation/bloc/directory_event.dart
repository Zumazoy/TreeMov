part of 'directory_bloc.dart';

abstract class DirectoryEvent extends Equatable {
  const DirectoryEvent();

  @override
  List<Object> get props => [];
}

class LoadStudentGroups extends DirectoryEvent {}

class LoadStudentsInGroup extends DirectoryEvent {
  final int groupId;

  const LoadStudentsInGroup({required this.groupId});

  @override
  List<Object> get props => [groupId];
}

class LoadAllGroupsWithCounts extends DirectoryEvent {}
