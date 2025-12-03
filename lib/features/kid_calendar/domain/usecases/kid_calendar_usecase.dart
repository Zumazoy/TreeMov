import 'package:treemov/features/kid_calendar/domain/entities/kid_event_entity.dart';
import 'package:treemov/features/kid_calendar/domain/repositories/kid_calendar_repository.dart';

class GetKidCalendarUseCase {
  final KidCalendarRepository repository;

  GetKidCalendarUseCase(this.repository);

  Future<List<KidEventEntity>> call({int? kidId}) {
    return repository.getKidEvents(kidId: kidId);
  }
}
