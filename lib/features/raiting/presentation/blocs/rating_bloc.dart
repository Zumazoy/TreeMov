import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';

import '../../domain/repositories/rating_repository.dart';
import 'rating_event.dart';
import 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RatingRepository _repository;
  List<GroupStudentsResponseModel> _groups = [];
  GroupStudentsResponseModel? _selectedGroup;

  RatingBloc(this._repository) : super(RatingInitial()) {
    on<LoadStudentGroupsEvent>(_onLoadStudentGroups);
    on<LoadStudentsForGroupEvent>(_onLoadStudentsForGroup);
    on<LoadCurrentStudentEvent>(_onLoadCurrentStudent);
    on<ChangeGroupEvent>(_onChangeGroup);
  }

  Future<void> _onLoadStudentGroups(
    LoadStudentGroupsEvent event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());
    try {
      _groups = await _repository.getStudentGroups();

      if (_groups.isEmpty) {
        // Если групп нет, загружаем всех студентов
        final students = await _repository.getStudents();
        final currentStudent = await _repository.getCurrentStudent();
        emit(
          StudentsLoaded(
            students: students,
            groups: [],
            currentStudent: currentStudent,
          ),
        );
      } else {
        // По умолчанию выбираем первую группу
        _selectedGroup = _groups.first;
        // Проверяем, что id не null
        if (_selectedGroup!.id != null) {
          final students = await _repository.getStudentsByGroup(
            _selectedGroup!.id!,
          );
          final currentStudent = await _repository.getCurrentStudent();
          emit(
            StudentsLoaded(
              students: students,
              groups: _groups,
              selectedGroup: _selectedGroup,
              currentStudent: currentStudent,
            ),
          );
        } else {
          // Если id группы null, загружаем всех студентов
          final students = await _repository.getStudents();
          final currentStudent = await _repository.getCurrentStudent();
          emit(
            StudentsLoaded(
              students: students,
              groups: _groups,
              selectedGroup: _selectedGroup,
              currentStudent: currentStudent,
            ),
          );
        }
      }
    } catch (e) {
      emit(RatingError('Ошибка загрузки групп: $e'));
    }
  }

  Future<void> _onLoadStudentsForGroup(
    LoadStudentsForGroupEvent event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());
    try {
      // Проверяем, что id группы не null
      if (event.group.id != null) {
        final students = await _repository.getStudentsByGroup(event.group.id!);
        final currentStudent = await _repository.getCurrentStudent();
        emit(
          StudentsLoaded(
            students: students,
            groups: _groups,
            selectedGroup: event.group,
            currentStudent: currentStudent,
          ),
        );
      } else {
        // Если id группы null, показываем ошибку
        emit(RatingError('ID группы не может быть null'));
      }
    } catch (e) {
      emit(RatingError('Ошибка загрузки студентов: $e'));
    }
  }

  Future<void> _onLoadCurrentStudent(
    LoadCurrentStudentEvent event,
    Emitter<RatingState> emit,
  ) async {
    try {
      final currentStudent = await _repository.getCurrentStudent();

      if (state is StudentsLoaded) {
        final currentState = state as StudentsLoaded;
        emit(
          StudentsLoaded(
            students: currentState.students,
            groups: currentState.groups,
            selectedGroup: currentState.selectedGroup,
            currentStudent: currentStudent,
          ),
        );
      }
    } catch (e) {
      // Игнорируем ошибку загрузки текущего студента
    }
  }

  Future<void> _onChangeGroup(
    ChangeGroupEvent event,
    Emitter<RatingState> emit,
  ) async {
    _selectedGroup = event.group;
    add(LoadStudentsForGroupEvent(event.group));
  }
}
