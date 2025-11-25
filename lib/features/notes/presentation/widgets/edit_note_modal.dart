import 'package:flutter/material.dart';

import '../../domain/entities/teacher_note_entity.dart';
import 'note_form.dart';

class EditNoteModal extends StatelessWidget {
  final TeacherNoteEntity note;
  final Function(TeacherNoteEntity) onNoteUpdated;

  const EditNoteModal({
    super.key,
    required this.note,
    required this.onNoteUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return NoteForm(
      title: 'Редактировать заметку',
      buttonText: 'Сохранить',
      initialTitle: note.title,
      initialContent: note.content,
      initialCategory: note.category,
      initialIsPinned: note.isPinned,
      onSubmit: (title, content, category, isPinned) {
        final updatedNote = note.copyWith(
          title: title,
          content: content,
          category: category,
          isPinned: isPinned,
        );
        onNoteUpdated(updatedNote);
        Navigator.pop(context);
      },
    );
  }
}
