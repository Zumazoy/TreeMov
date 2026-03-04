import 'package:equatable/equatable.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object?> get props => [];
}

class LoadStudentGroupsEvent extends RatingEvent {
  const LoadStudentGroupsEvent();
}

class LoadStudentsForGroupEvent extends RatingEvent {
  final GroupStudentsResponseModel group;

  const LoadStudentsForGroupEvent(this.group);

  @override
  List<Object?> get props => [group];
}

class LoadCurrentStudentEvent extends RatingEvent {
  const LoadCurrentStudentEvent();
}

class ChangeGroupEvent extends RatingEvent {
  final GroupStudentsResponseModel group;

  const ChangeGroupEvent(this.group);

  @override
  List<Object?> get props => [group];
}
