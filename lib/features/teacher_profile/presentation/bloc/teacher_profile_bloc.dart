import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/teacher_profile_response_model.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

part 'teacher_profile_event.dart';
part 'teacher_profile_state.dart';

class TeacherProfileBloc
    extends Bloc<TeacherProfileEvent, TeacherProfileState> {
  final SharedRepository _sharedRepository;

  TeacherProfileBloc(this._sharedRepository)
    : super(TeacherProfileState.initial()) {
    on<LoadTeacherProfile>(_onLoadTeacherProfile);
    on<LoadLessons>(_onLoadLessons);
  }

  Future<void> _onLoadTeacherProfile(
    LoadTeacherProfile event,
    Emitter<TeacherProfileState> emit,
  ) async {
    emit(state.copyWith(isLoadingProfile: true, profileError: null));
    try {
      final teacherProfile = await _sharedRepository.getMyTeacherProfile();
      emit(
        state.copyWith(teacherProfile: teacherProfile, isLoadingProfile: false),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingProfile: false, profileError: e.toString()));
    }
  }

  Future<void> _onLoadLessons(
    LoadLessons event,
    Emitter<TeacherProfileState> emit,
  ) async {
    emit(state.copyWith(isLoadingLessons: true, lessonsError: null));
    try {
      final lessons = await _sharedRepository.getLessons();
      final todayLessons = _filterTodayLessons(lessons);
      emit(state.copyWith(lessons: todayLessons, isLoadingLessons: false));
    } catch (e) {
      emit(state.copyWith(isLoadingLessons: false, lessonsError: e.toString()));
    }
  }

  List<LessonResponseModel> _filterTodayLessons(
    List<LessonResponseModel> lessons,
  ) {
    final now = DateTime.now();
    final todayStr =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    return lessons.where((lesson) {
      if (lesson.date == null) return false;
      if (lesson.date != todayStr) return false;
      if (lesson.isCanceled == true) return false;
      return true;
    }).toList();
  }
}
