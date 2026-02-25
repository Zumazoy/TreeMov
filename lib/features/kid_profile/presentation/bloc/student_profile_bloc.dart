import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    on<LoadMoreActivities>(_onLoadMoreActivities);
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
    } catch (e) {
      emit(state.copyWith(isLoadingProfile: false, profileError: e.toString()));
    }
  }

  Future<void> _onLoadStudentActivities(
    LoadStudentActivities event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(state.copyWith(isLoadingActivities: true, activitiesError: null));
    try {
      final activities = await _sharedRepository.getStudentAccruals(
        studentId: state.studentProfile?.id,
        page: 1,
      );
      emit(
        state.copyWith(
          activities: activities,
          currentPage: 1,
          hasMorePages: activities.length >= 20,
          isLoadingActivities: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingActivities: false,
          activitiesError: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadMoreActivities(
    LoadMoreActivities event,
    Emitter<StudentProfileState> emit,
  ) async {
    if (state.isLoadingMoreActivities || !state.hasMorePages) return;

    emit(state.copyWith(isLoadingMoreActivities: true));
    try {
      final nextPage = state.currentPage + 1;
      final moreActivities = await _sharedRepository.getStudentAccruals(
        studentId: state.studentProfile?.id,
        page: nextPage,
      );
      final updatedActivities = [...state.activities, ...moreActivities];

      emit(
        state.copyWith(
          activities: updatedActivities,
          currentPage: nextPage,
          hasMorePages: moreActivities.length >= 20,
          isLoadingMoreActivities: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMoreActivities: false,
          activitiesError: e.toString(),
        ),
      );
    }
  }
}
