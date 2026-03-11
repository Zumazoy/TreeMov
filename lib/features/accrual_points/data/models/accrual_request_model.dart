class AccrualRequestModel {
  final int amount;
  final int studentId;
  final String category;
  final String? comment;

  AccrualRequestModel({
    required this.studentId,
    required this.amount,
    required this.category,
    this.comment,
  });

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'student_id': studentId,
    'category': category,
    if (comment != null) 'comment': comment,
  };
}
