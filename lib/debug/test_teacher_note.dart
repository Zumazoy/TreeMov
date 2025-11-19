import 'package:treemov/features/notes/data/models/teacher_note_response_model.dart';

void testTeacherNote() {
  final json = {
    "id": 1,
    "created_at": "2025-11-18T18:32:49.728718+07:00",
    "title": "hjgfhj",
    "text": "ghfjndhgjhgjf",
    "category": "general",
    "org": 1,
    "created_by": 3,
    "teacher_profile": 1,
  };

  final note = TeacherNoteResponseModel.fromJson(json);

  print('=== TEST TEACHER NOTE ===');
  print('ID: ${note.id}');
  print('Title: ${note.title}');
  print('Text: ${note.text}');
  print('Category: ${note.category}');
  print('Created: ${note.createdAt}');
  print('Formatted: ${note.formattedCreatedDate}');
  print('TeacherProfile: ${note.teacherProfile}');
}
