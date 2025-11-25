import '../../domain/entities/report_entity.dart';

class MockReportsData {
  static List<ReportEntity> get mockReports => [
    const ReportEntity(
      id: '1',
      title: 'Успеваемость группы ТехноГик',
      period: 'Октябрь 2024',
      size: '2.3 MB',
      updateTime: '2 часа назад',
      status: ReportStatus.ready,
    ),
    const ReportEntity(
      id: '2',
      title: 'Посещаемость за неделю',
      period: '21-27 октября',
      size: '1.1 MB',
      updateTime: '1 день назад',
      status: ReportStatus.ready,
    ),
    const ReportEntity(
      id: '3',
      title: 'Рейтинг учеников по баллам',
      period: 'Текущий месяц',
      size: '—',
      updateTime: 'Генерируется...',
      status: ReportStatus.generating,
    ),
    const ReportEntity(
      id: '4',
      title: 'Сводный отчет по предметам',
      period: 'Сентябрь 2024',
      size: '3.5 MB',
      updateTime: '2 недели назад',
      status: ReportStatus.ready,
    ),
  ];
}
