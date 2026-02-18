part of 'directory_bloc.dart';

abstract class DirectoryEvent extends Equatable {
  const DirectoryEvent();

  @override
  List<Object> get props => [];
}

class LoadAllGroupsWithCounts extends DirectoryEvent {}
