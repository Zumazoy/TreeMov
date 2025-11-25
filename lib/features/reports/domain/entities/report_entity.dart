enum ReportStatus {
  ready('Готов'),
  generating('Генерируется'),
  error('Ошибка');

  final String title;
  const ReportStatus(this.title);
}

class ReportEntity {
  final String id;
  final String title;
  final String period;
  final String? size;
  final String updateTime;
  final ReportStatus status;

  const ReportEntity({
    required this.id,
    required this.title,
    required this.period,
    this.size,
    required this.updateTime,
    required this.status,
  });
}
