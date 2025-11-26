part of 'directory_bloc.dart';

abstract class DirectoryState extends Equatable {
  const DirectoryState();

  @override
  List<Object> get props => [];
}

class DirectoryInitial extends DirectoryState {}

class DirectoryLoading extends DirectoryState {}

class GroupsLoaded extends DirectoryState {
  final List<StudentGroupResponseModel> groups;

  const GroupsLoaded(this.groups);

  @override
  List<Object> get props => [groups];
}

class DirectoryError extends DirectoryState {
  final String message;

  const DirectoryError(this.message);

  @override
  List<Object> get props => [message];
}
