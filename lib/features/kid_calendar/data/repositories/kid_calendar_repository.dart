import 'package:treemov/features/kid_calendar/data/datasources/kid_calendar_remote_datasource.dart';
import 'package:treemov/features/kid_calendar/data/models/kid_event_model.dart';
import 'package:treemov/features/kid_calendar/domain/entities/kid_event_entity.dart';
import 'package:treemov/features/kid_calendar/domain/repositories/kid_calendar_repository.dart'
    as domain_repo;

class KidCalendarRepositoryImpl implements domain_repo.KidCalendarRepository {
  final KidCalendarRemoteDataSource remote;
  KidCalendarRepositoryImpl(this.remote);

  @override
  Future<List<KidEventEntity>> getKidEvents({int? kidId}) async {
    final List<KidEventModel> models = await remote.getKidEvents(kidId: kidId);
    return models.map((m) => m.toEntity()).toList();
  }
}
