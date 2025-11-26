import 'package:treemov/features/notes/domain/entities/note_category_entity.dart';

class TeacherNoteRequestModel {
  final String title;
  final String text;
  final NoteCategoryEntity category;

  TeacherNoteRequestModel({
    required this.title,
    required this.text,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'text': text,
    'category': category.apiValue,
  };
}
