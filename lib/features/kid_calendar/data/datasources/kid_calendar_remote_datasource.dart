import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/features/kid_calendar/data/models/kid_event_model.dart';

class KidCalendarRemoteDataSource {
  final Dio dio;
  KidCalendarRemoteDataSource(this.dio);

  Future<List<KidEventModel>> getKidEvents({int? kidId}) async {
    final String url = ApiConstants.baseUrl + ApiConstants.lessons;
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;
      if (data is List) {
        return KidEventModel.fromJsonList(data);
      } else if (data is Map && data.containsKey('results')) {
        return KidEventModel.fromJsonList(data['results'] as List<dynamic>);
      }
    }
    return [];
  }
}
