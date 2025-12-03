import 'package:treemov/features/kid_calendar/domain/entities/kid_event_entity.dart';

abstract class KidCalendarRepository {
  Future<List<KidEventEntity>> getKidEvents({int? kidId});
}
