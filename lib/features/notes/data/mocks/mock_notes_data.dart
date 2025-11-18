import 'package:treemov/features/notes/domain/entities/note_category_entity.dart';
import 'package:treemov/features/notes/domain/entities/teacher_note_entity.dart';

class MockNotesData {
  static List<TeacherNoteEntity> get mockNotes => [
    TeacherNoteEntity(
      id: '1',
      title: 'Поведение на уроке',
      content:
          'Иван Петров сегодня очень активно участвовал в обсуждении темы "Циклы". Нужно отметить его старание.',
      date: DateTime(2025, 10, 28),
      category: NoteCategoryEntity.behavior,
      isPinned: true,
      isToday: true,
    ),
    TeacherNoteEntity(
      id: '2',
      title: 'Планы на неделю',
      content:
          'Подготовить материалы для контрольной работы по математике. Проверить готовность кабинета к практическому занятию.',
      date: DateTime(2025, 10, 28),
      category: NoteCategoryEntity.general,
      isPinned: true,
      isToday: true,
    ),
    TeacherNoteEntity(
      id: '3',
      title: 'Родительское собрание',
      content:
          'Обсудить с родителями Алины Сидоровой её успехи в математике. Предложить дополнительные занятия.',
      date: DateTime(2025, 10, 27),
      category: NoteCategoryEntity.parents,
      isPinned: false,
      isToday: false,
    ),
    TeacherNoteEntity(
      id: '4',
      title: 'Домашнее задание',
      content:
          'Максим Козлов не сдал домашнее задание по русскому языку. Нужно выяснить причину и дать дополнительное время.',
      date: DateTime(2025, 10, 26),
      category: NoteCategoryEntity.study,
      isPinned: false,
      isToday: false,
    ),
    TeacherNoteEntity(
      id: '5',
      title: 'Подготовка к олимпиаде',
      content:
          'Отобрать учеников для участия в школьной олимпиаде по физике. Составить план подготовки.',
      date: DateTime(2025, 10, 25),
      category: NoteCategoryEntity.study,
      isPinned: false,
      isToday: false,
    ),
  ];
}
