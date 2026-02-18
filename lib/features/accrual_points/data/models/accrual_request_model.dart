class AccrualRequestModel {
  final int teacherId;
  final int studentId;
  final int amount;
  final String? category;
  final String? comment;

  AccrualRequestModel({
    required this.teacherId,
    required this.studentId,
    required this.amount,
    required this.category,
    required this.comment,
  });

  Map<String, dynamic> toJson() => {
    'teacher_id': teacherId,
    'student_id': studentId,
    'amount': amount,
    'category': category,
    'comment': comment,
  };
}
