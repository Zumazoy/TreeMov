class AttendanceRequestModel {
  final int? studentId;
  final int? lessonId;
  final bool wasPresent;
  final String? comment;

  AttendanceRequestModel({
    this.studentId,
    this.lessonId,
    required this.wasPresent,
    this.comment,
  });

  Map<String, dynamic> toJson() => {
    if (studentId != null) 'student_id': studentId,
    if (lessonId != null) 'lesson_id': lessonId,
    'was_present': wasPresent,
    if (comment != null) 'comment': comment,
  };
}
