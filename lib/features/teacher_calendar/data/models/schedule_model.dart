class ScheduleModel {
  final int id;
  final String title;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String teacher;
  final String groupName;
  final String classroom;
  final bool isCanceled;
  final bool isCompleted;

  ScheduleModel({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.teacher,
    required this.groupName,
    required this.classroom,
    required this.isCanceled,
    required this.isCompleted,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    String teacherName = '';
    try {
      final teacher = json['teacher'];
      final employer = teacher != null ? teacher['employer'] : null;
      if (employer != null) {
        final name = employer['name'] ?? '';
        final surname = employer['surname'] ?? '';
        final patronymic = employer['patronymic'] ?? '';
        teacherName = [
          surname,
          name,
          patronymic,
        ].where((s) => s != '').join(' ');
      }
    } catch (_) {}

    String groupName = '';
    try {
      final group = json['group'];
      if (group != null) groupName = group['name'] ?? '';
    } catch (_) {}

    String classroom = '';
    try {
      final room = json['classroom'];
      if (room != null) classroom = room['title'] ?? '';
    } catch (_) {}

    return ScheduleModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      date: json['date'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      teacher: teacherName,
      groupName: groupName,
      classroom: classroom,
      isCanceled: json['is_canceled'] == true,
      isCompleted: json['is_completed'] == true,
    );
  }
}
