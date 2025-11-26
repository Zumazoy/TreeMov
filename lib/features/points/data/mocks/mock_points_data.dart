import '../../domain/entities/point_entity.dart';
import '../../domain/entities/point_category_entity.dart';

class MockPointsData {
  static final List<PointAction> pointActions = [
    PointAction(
      id: 'act1',
      category: PointCategory.activity,
      title: 'Активность на занятии',
      description: 'проявлял интерес на занятии',
      points: 5,
    ),
    PointAction(
      id: 'act2',
      category: PointCategory.activity,
      title: 'Хороший ответ/вопрос',
      description: 'Включен в дискуссию',
      points: 3,
    ),
    PointAction(
      id: 'act3',
      category: PointCategory.activity,
      title: 'Помощь другу',
      description: 'Помог товарищу',
      points: 4,
    ),
    PointAction(
      id: 'act4',
      category: PointCategory.activity,
      title: 'Пассивность',
      description: 'Игнорировал задания',
      points: -2,
    ),
    PointAction(
      id: 'beh1',
      category: PointCategory.behavior,
      title: 'Образцовое поведение',
      description: 'Показал отличное поведение',
      points: 5,
    ),
    PointAction(
      id: 'beh2',
      category: PointCategory.behavior,
      title: 'Лидерство',
      description: 'Проявил лидерские качества',
      points: 4,
    ),
    PointAction(
      id: 'beh3',
      category: PointCategory.behavior,
      title: 'Уважение к другим',
      description: 'Проявил уважение к товарищам',
      points: 3,
    ),
    PointAction(
      id: 'beh4',
      category: PointCategory.behavior,
      title: 'Нарушение дисциплины',
      description: 'Мешал проведению занятия',
      points: -3,
    ),
    PointAction(
      id: 'beh5',
      category: PointCategory.behavior,
      title: 'Неуважение',
      description: 'Проявил неуважение',
      points: -5,
    ),
    PointAction(
      id: 'ach1',
      category: PointCategory.achievement,
      title: 'Победа в конкурсе',
      description: 'Занял 1 место',
      points: 10,
    ),
    PointAction(
      id: 'ach2',
      category: PointCategory.achievement,
      title: 'Призовое место',
      description: 'Занял призовое место',
      points: 7,
    ),
    PointAction(
      id: 'ach3',
      category: PointCategory.achievement,
      title: 'Участие в конкурсе',
      description: 'Был участником конкурса',
      points: 3,
    ),
    PointAction(
      id: 'hw1',
      category: PointCategory.homework,
      title: 'Отличная работа',
      description: 'Выполнил ДЗ на отлично',
      points: 5,
    ),
    PointAction(
      id: 'hw2',
      category: PointCategory.homework,
      title: 'Хорошая работа',
      description: 'Выполнил ДЗ хорошо',
      points: 3,
    ),
    PointAction(
      id: 'hw3',
      category: PointCategory.homework,
      title: 'Выполнено',
      description: 'Выполнил ДЗ',
      points: 1,
    ),
    PointAction(
      id: 'hw4',
      category: PointCategory.homework,
      title: 'Сдал с опозданием',
      description: 'Сдал ДЗ позже срока',
      points: -1,
    ),
    PointAction(
      id: 'hw5',
      category: PointCategory.homework,
      title: 'Не выполнено',
      description: 'Не сделал ДЗ',
      points: -5,
    ),
  ];

  static final List<PointEntity> mockPointsHistory = [
    PointEntity(
      id: '1',
      studentId: '1',
      studentName: 'Иван Петров',
      points: 5,
      category: PointCategory.activity,
      actionTitle: 'Активность на занятии',
      reason: 'проявлял интерес на занятии',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PointEntity(
      id: '2',
      studentId: '1',
      studentName: 'Иван Петров',
      points: -2,
      category: PointCategory.activity,
      actionTitle: 'Пассивность',
      reason: 'Игнорировал задания',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  static final List<StudentWithPoints> mockStudentsWithPoints = [
    StudentWithPoints(
      studentId: '1',
      fullName: 'Иван Петров',
      totalPoints: 265,
      attendancePercentage: 0.85,
    ),
    StudentWithPoints(
      studentId: '2',
      fullName: 'Мария Сидорова',
      totalPoints: 240,
      attendancePercentage: 0.92,
    ),
    StudentWithPoints(
      studentId: '3',
      fullName: 'Алексей Иванов',
      totalPoints: 255,
      attendancePercentage: 0.78,
    ),
    StudentWithPoints(
      studentId: '4',
      fullName: 'Екатерина Смирнова',
      totalPoints: 230,
      attendancePercentage: 0.95,
    ),
  ];

  static List<PointAction> getActionsByCategory(PointCategory category) {
    return pointActions.where((action) => action.category == category).toList();
  }
}

class StudentWithPoints {
  final String studentId;
  final String fullName;
  final String? avatarUrl;
  final int totalPoints;
  final double attendancePercentage;

  StudentWithPoints({
    required this.studentId,
    required this.fullName,
    this.avatarUrl,
    required this.totalPoints,
    required this.attendancePercentage,
  });
}
