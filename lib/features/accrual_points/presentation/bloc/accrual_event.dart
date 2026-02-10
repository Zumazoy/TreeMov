part of 'accrual_bloc.dart';

abstract class AccrualEvent extends Equatable {
  const AccrualEvent();

  @override
  List<Object?> get props => [];
}

class LoadStudentGroups extends AccrualEvent {}

class LoadTeacherProfileId extends AccrualEvent {}

class CreateAccrual extends AccrualEvent {
  final AccrualRequestModel request;

  const CreateAccrual(this.request);

  @override
  List<Object?> get props => [request];
}
