import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';

abstract class KidCalendarRepository {
  Future<List<LessonEntity>> getLessons({String? dateMin, String? dateMax});
}
