class AccrualRequestModel {
  final int teacherProfile;
  final int student;
  final int amount;
  final String? category;
  final String? comment;

  AccrualRequestModel({
    required this.teacherProfile,
    required this.student,
    required this.amount,
    required this.category,
    required this.comment,
  });

  Map<String, dynamic> toJson() => {
    'teacher_profile': teacherProfile,
    'student': student,
    'amount': amount,
    'category': category,
    'comment': comment,
  };
}
