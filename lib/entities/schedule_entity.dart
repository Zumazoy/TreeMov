class ScheduleEntity {
  final BigInt id;
  final BigInt? classroomId;
  final BigInt? createdById;
  final BigInt? groupId;
  final BigInt orgId;
  final BigInt? periodScheduleId;
  final BigInt teacherId;
  final BigInt? subjectId;
  final int weekDay;
  final int? lesson;
  final String? title;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime date;
  final DateTime createdAt;
  final Duration duration;
  final bool? isCanceled;
  final bool? isCompleted;

  ScheduleEntity({
    required this.id,
    required this.classroomId,
    required this.createdById,
    required this.groupId,
    required this.orgId,
    required this.periodScheduleId,
    required this.teacherId,
    required this.subjectId,
    required this.weekDay,
    required this.lesson,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.createdAt,
    required this.duration,
    required this.isCanceled,
    required this.isCompleted,
  });
}
