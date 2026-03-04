import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:treemov/shared/data/models/accrual_response_model.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  final SharedRepository _sharedRepository;

  StudentProfileBloc(this._sharedRepository)
    : super(StudentProfileState.initial()) {
    on<LoadStudentProfile>(_onLoadStudentProfile);
    on<LoadStudentActivities>(_onLoadStudentActivities);
  }

  Future<void> _onLoadStudentProfile(
    LoadStudentProfile event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(isLoadingProfile: true, profileError: null));
    try {
      final studentProfile = await _sharedRepository.getStudentProfile();
      emit(
        state.copyWith(studentProfile: studentProfile, isLoadingProfile: false),
      );

      if (studentProfile.id != null) {
        debugPrint(
          '🔄 Автоматическая загрузка активностей для ученика ID: ${studentProfile.id}',
        );
        add(LoadStudentActivities());
      }
    } catch (e) {
      debugPrint('❌ Ошибка загрузки профиля: $e');
      emit(state.copyWith(isLoadingProfile: false, profileError: e.toString()));
    }
  }

  Future<void> _onLoadStudentActivities(
    LoadStudentActivities event,
    Emitter<StudentProfileState> emit,
  ) async {
    final studentId = state.studentProfile?.id;
    debugPrint('📝 Загрузка активностей для ученика ID: $studentId');

    if (studentId == null) {
      debugPrint('❌ ID ученика не найден');
      emit(
        state.copyWith(
          activitiesError: 'ID ученика не найден',
          isLoadingActivities: false,
        ),
      );
      return;
    }

    emit(state.copyWith(isLoadingActivities: true, activitiesError: null));

    try {
      final allActivities = await _sharedRepository.getStudentAccruals(
        studentId: studentId,
        page: 1,
      );

      debugPrint(
        '📊 Получено всего начислений от сервера: ${allActivities.length}',
      );
      final filteredActivities = allActivities.where((accrual) {
        return accrual.student?.id == studentId;
      }).toList();

      debugPrint(
        '📊 Отфильтровано для ученика $studentId: ${filteredActivities.length}',
      );
      final lastTenActivities = filteredActivities.take(10).toList();

      debugPrint('📊 Показываем последние 10: ${lastTenActivities.length}');
      emit(
        state.copyWith(
          activities: lastTenActivities,
          isLoadingActivities: false,
        ),
      );
    } catch (e) {
      debugPrint('❌ Ошибка загрузки активностей: $e');
      emit(
        state.copyWith(
          isLoadingActivities: false,
          activitiesError: e.toString(),
        ),
      );
    }
  }
}
