import 'package:treemov/features/notes/domain/entities/note_category_entity.dart';

class TeacherNoteRequestModel {
  final String title;
  final String text;
  final NoteCategoryEntity category;
  final int teacherProfileId;

  TeacherNoteRequestModel({
    required this.title,
    required this.text,
    required this.category,
    required this.teacherProfileId,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'text': text,
    'category': category.apiValue,
    'teacher_profile': teacherProfileId,
  };
}
