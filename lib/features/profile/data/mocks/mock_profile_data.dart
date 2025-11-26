import '../../domain/entities/daily_schedule_entity.dart';
import '../../domain/entities/teacher_entity.dart';

class MockProfileData {
  static TeacherEntity get mockTeacher => TeacherEntity(
    id: '1',
    firstName: 'Елена',
    lastName: 'Ивановна',
    middleName: 'Петрова',
    position: 'Преподаватель по робототехнике',
    avatarUrl: null,
  );

  static DailyScheduleEntity get mockDailySchedule => DailyScheduleEntity(
    totalLessons: 3,
    nextLesson: NextLesson(
      group: 'ТехноГик',
      time: '09:40–10:25',
      isCompleted: true,
    ),
    reminders: [
      Reminder(
        text: 'Родительское собрание',
        time: '17:00',
        isCompleted: false,
      ),
    ],
  );
}
