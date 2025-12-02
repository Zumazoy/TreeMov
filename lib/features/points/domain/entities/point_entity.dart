import '../../domain/entities/point_category_entity.dart';

class PointEntity {
  final String id;
  final String studentId;
  final String studentName;
  final int points;
  final PointCategory category;
  final String actionTitle;
  final String reason;
  final DateTime date;
  final String? lessonId;
  final String? comment;

  PointEntity({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.points,
    required this.category,
    required this.actionTitle,
    required this.reason,
    required this.date,
    this.lessonId,
    this.comment,
  });
}
