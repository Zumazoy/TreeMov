import 'package:flutter/material.dart';
import '../../domain/entities/teacher_note_entity.dart';
import 'note_form.dart';

class CreateNoteModal extends StatelessWidget {
  final Function(TeacherNoteEntity) onNoteCreated;

  const CreateNoteModal({super.key, required this.onNoteCreated});

  @override
  Widget build(BuildContext context) {
    return NoteForm(
      title: 'Новая заметка',
      buttonText: 'Создать',
      onSubmit: (title, content, category, isPinned) {
        final newNote = TeacherNoteEntity(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          content: content,
          date: DateTime.now(),
          category: category,
          isPinned: isPinned,
          isToday: true,
        );
        onNoteCreated(newNote);
        Navigator.pop(context);
      },
    );
  }
}
