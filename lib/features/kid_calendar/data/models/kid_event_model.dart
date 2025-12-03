import 'package:treemov/features/kid_calendar/domain/entities/kid_event_entity.dart';

class KidEventModel {
  final int day;
  final String startTime;
  final String endTime;
  final String title;
  final String teacher;
  final String room;

  KidEventModel({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.teacher,
    required this.room,
  });

  factory KidEventModel.fromJson(Map<String, dynamic> json) {
    int dayValue = DateTime.now().day;
    if (json.containsKey('day') && json['day'] is int) {
      dayValue = json['day'] as int;
    } else if (json.containsKey('date') && json['date'] is String) {
      final dt = DateTime.tryParse(json['date'] as String);
      if (dt != null) dayValue = dt.day;
    }

    return KidEventModel(
      day: dayValue,
      startTime: (json['startTime'] ?? json['start_time'] ?? '').toString(),
      endTime: (json['endTime'] ?? json['end_time'] ?? '').toString(),
      title: (json['title'] ?? json['name'] ?? '').toString(),
      teacher: (json['teacher'] ?? '').toString(),
      room: (json['room'] ?? json['classroom'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'day': day,
    'startTime': startTime,
    'endTime': endTime,
    'title': title,
    'teacher': teacher,
    'room': room,
  };

  KidEventEntity toEntity() {
    return KidEventEntity(
      day: day,
      startTime: startTime,
      endTime: endTime,
      title: title,
      teacher: teacher,
      room: room,
    );
  }

  static List<KidEventModel> fromJsonList(List<dynamic> list) => list
      .map((e) => KidEventModel.fromJson(e as Map<String, dynamic>))
      .toList();
}
