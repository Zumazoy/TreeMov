part of 'student_profile_bloc.dart';

class StudentProfileState extends Equatable {
  final StudentResponseModel? studentProfile;
  final List<AccrualResponseModel> activities;
  final bool isLoadingProfile;
  final bool isLoadingActivities;
  final bool isLoadingMoreActivities;
  final String? profileError;
  final String? activitiesError;
  final int currentPage;
  final bool hasMorePages;

  const StudentProfileState({
    this.studentProfile,
    this.activities = const [],
    this.isLoadingProfile = false,
    this.isLoadingActivities = false,
    this.isLoadingMoreActivities = false,
    this.profileError,
    this.activitiesError,
    this.currentPage = 0,
    this.hasMorePages = true,
  });

  factory StudentProfileState.initial() => const StudentProfileState();

  StudentProfileState copyWith({
    StudentResponseModel? studentProfile,
    List<AccrualResponseModel>? activities,
    bool? isLoadingProfile,
    bool? isLoadingActivities,
    bool? isLoadingMoreActivities,
    String? profileError,
    String? activitiesError,
    int? currentPage,
    bool? hasMorePages,
  }) {
    return StudentProfileState(
      studentProfile: studentProfile ?? this.studentProfile,
      activities: activities ?? this.activities,
      isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
      isLoadingActivities: isLoadingActivities ?? this.isLoadingActivities,
      isLoadingMoreActivities:
          isLoadingMoreActivities ?? this.isLoadingMoreActivities,
      profileError: profileError ?? this.profileError,
      activitiesError: activitiesError ?? this.activitiesError,
      currentPage: currentPage ?? this.currentPage,
      hasMorePages: hasMorePages ?? this.hasMorePages,
    );
  }

  bool get hasProfileData => studentProfile != null;
  bool get hasActivities => activities.isNotEmpty;
  bool get hasError => profileError != null || activitiesError != null;

  // Вычисляемые данные для UI
  int get totalEarnings {
    return activities
        .where((a) => a.amount! > 0)
        .fold(0, (sum, a) => sum + a.amount!);
  }

  int get attendance {
    // В приложении здесь должен быть расчет из данных
    // Пока возвращаем заглушку, но можно будет добавить позже
    return 95;
  }

  int get achievementsCount {
    // В  приложении здесь должен быть подсчет из данных
    return 0;
  }

  int get currentPoints {
    return studentProfile?.score ??
        activities.fold(0, (sum, a) => sum + a.amount!);
  }

  @override
  List<Object?> get props => [
    studentProfile,
    activities,
    isLoadingProfile,
    isLoadingActivities,
    isLoadingMoreActivities,
    profileError,
    activitiesError,
    currentPage,
    hasMorePages,
  ];
}
