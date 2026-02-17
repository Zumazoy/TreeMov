import 'package:equatable/equatable.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object?> get props => [];
}

class LoadStudentsEvent extends RatingEvent {
  const LoadStudentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCurrentStudentEvent extends RatingEvent {
  const LoadCurrentStudentEvent();

  @override
  List<Object?> get props => [];
}