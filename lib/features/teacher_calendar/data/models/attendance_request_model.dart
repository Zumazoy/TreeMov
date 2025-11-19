class AttendanceRequestModel {
  final int student;
  final int lesson;
  final bool wasPresent;

  AttendanceRequestModel({
    required this.student,
    required this.lesson,
    required this.wasPresent,
  });

  Map<String, dynamic> toJson() => {
    'student': student,
    'lesson': lesson,
    'was_present': wasPresent,
  };
}
