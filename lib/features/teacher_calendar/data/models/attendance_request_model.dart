class AttendanceRequestModel {
  final int studentId;
  final int lessonId;
  final bool wasPresent;
  final String? comment;

  AttendanceRequestModel({
    required this.studentId,
    required this.lessonId,
    required this.wasPresent,
    this.comment,
  });

  Map<String, dynamic> toJson() => {
    'student_id': studentId,
    'lesson_id': lessonId,
    'was_present': wasPresent,
    'comment': comment,
  };
}
