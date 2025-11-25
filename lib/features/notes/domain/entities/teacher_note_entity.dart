import 'note_category_entity.dart';

class TeacherNoteEntity {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final NoteCategoryEntity category;
  bool isPinned;
  bool isToday;

  TeacherNoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
    this.isPinned = false,
    this.isToday = false,
  });

  void togglePin() {
    isPinned = !isPinned;
  }

  TeacherNoteEntity copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? date,
    NoteCategoryEntity? category,
    bool? isPinned,
    bool? isToday,
  }) {
    return TeacherNoteEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      category: category ?? this.category,
      isPinned: isPinned ?? this.isPinned,
      isToday: isToday ?? this.isToday,
    );
  }
}
