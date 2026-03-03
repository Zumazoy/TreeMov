part of 'student_profile_bloc.dart';

class StudentProfileState extends Equatable {
  final StudentResponseModel? studentProfile;
  final List<AccrualResponseModel> activities;
  final bool isLoadingProfile;
  final bool isLoadingActivities;
  final String? profileError;
  final String? activitiesError;

  const StudentProfileState({
    this.studentProfile,
    this.activities = const [],
    this.isLoadingProfile = false,
    this.isLoadingActivities = false,
    this.profileError,
    this.activitiesError,
  });

  factory StudentProfileState.initial() => const StudentProfileState();

  StudentProfileState copyWith({
    StudentResponseModel? studentProfile,
    List<AccrualResponseModel>? activities,
    bool? isLoadingProfile,
    bool? isLoadingActivities,
    String? profileError,
    String? activitiesError,
  }) {
    return StudentProfileState(
      studentProfile: studentProfile ?? this.studentProfile,
      activities: activities ?? this.activities,
      isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
      isLoadingActivities: isLoadingActivities ?? this.isLoadingActivities,
      profileError: profileError ?? this.profileError,
      activitiesError: activitiesError ?? this.activitiesError,
    );
  }

  int get totalEarnings {
    return activities
        .where((a) => a.amount! > 0)
        .fold(0, (sum, a) => sum + a.amount!);
  }

  int get currentPoints {
    return studentProfile?.score ??
        activities.fold(0, (sum, a) => sum + a.amount!);
  }

  int get achievementsCount {
    return 0;
  }

  @override
  List<Object?> get props => [
    studentProfile,
    activities,
    isLoadingProfile,
    isLoadingActivities,
    profileError,
    activitiesError,
  ];
}
