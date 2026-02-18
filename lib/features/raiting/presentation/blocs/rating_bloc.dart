import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../domain/repositories/rating_repository.dart';
import 'rating_event.dart';
import 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RatingRepository _repository;

  RatingBloc(this._repository) : super(RatingInitial()) {
    on<LoadStudentsEvent>(_onLoadStudents);
    on<LoadCurrentStudentEvent>(_onLoadCurrentStudent);
  }

  Future<void> _onLoadStudents(
    LoadStudentsEvent event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());
    try {
      final students = await _repository.getStudents();
      emit(StudentsLoaded(students));
    } catch (e) {
      emit(RatingError('Ошибка загрузки студентов: $e'));
    }
  }

  Future<void> _onLoadCurrentStudent(
    LoadCurrentStudentEvent event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());
    try {
      final currentStudent = await _repository.getCurrentStudent();
      emit(CurrentStudentLoaded(currentStudent));
    } catch (e) {
      emit(RatingError('Ошибка загрузки текущего студента: $e'));
    }
  }
}
