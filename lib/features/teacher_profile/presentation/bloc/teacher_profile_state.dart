part of 'teacher_profile_bloc.dart';

class TeacherProfileState extends Equatable {
  final TeacherProfileResponseModel? teacherProfile;
  final List<LessonResponseModel>? lessons;
  final bool isLoadingProfile;
  final bool isLoadingLessons;
  final String? profileError;
  final String? lessonsError;

  const TeacherProfileState({
    this.teacherProfile,
    this.lessons,
    this.isLoadingProfile = false,
    this.isLoadingLessons = false,
    this.profileError,
    this.lessonsError,
  });

  factory TeacherProfileState.initial() => const TeacherProfileState();

  TeacherProfileState copyWith({
    TeacherProfileResponseModel? teacherProfile,
    List<LessonResponseModel>? lessons,
    bool? isLoadingProfile,
    bool? isLoadingLessons,
    String? profileError,
    String? lessonsError,
  }) {
    return TeacherProfileState(
      teacherProfile: teacherProfile ?? this.teacherProfile,
      lessons: lessons ?? this.lessons,
      isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
      isLoadingLessons: isLoadingLessons ?? this.isLoadingLessons,
      profileError: profileError ?? this.profileError,
      lessonsError: lessonsError ?? this.lessonsError,
    );
  }

  bool get hasProfileData => teacherProfile != null;
  bool get hasLessonsData => lessons != null;
  bool get hasError => profileError != null || lessonsError != null;

  @override
  List<Object?> get props => [
    teacherProfile,
    lessons,
    isLoadingProfile,
    isLoadingLessons,
    profileError,
    lessonsError,
  ];
}
