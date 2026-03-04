import 'package:treemov/features/kid_calendar/domain/repositories/kid_calendar_repository.dart';
import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

class KidCalendarRepositoryImpl implements KidCalendarRepository {
  final SharedRepository _sharedRepository;

  KidCalendarRepositoryImpl(this._sharedRepository);

  @override
  Future<List<LessonEntity>> getLessons({
    String? dateMin,
    String? dateMax,
  }) async {
    final lessons = await _sharedRepository.getLessons(
      dateMin: dateMin,
      dateMax: dateMax,
    );

    return lessons.map((model) {
      return LessonEntity(
        id: model.baseData.id,
        title: model.title,
        startTime: model.startTime,
        endTime: model.endTime,
        date: model.date,
        weekDay: model.weekDay,
        isCanceled: model.isCanceled,
        isCompleted: model.isCompleted,
        duration: model.duration,
        comment: model.comment,
        teacher: model.teacher,
        subject: model.subject,
        group: model.group,
        classroom: model.classroom,
      );
    }).toList();
  }
}
