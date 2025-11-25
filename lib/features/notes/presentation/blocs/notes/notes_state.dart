import 'package:treemov/features/notes/domain/entities/teacher_note_entity.dart';

abstract class NotesState {
  const NotesState();
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<TeacherNoteEntity> notes;

  const NotesLoaded(this.notes);
}

// Состояние для отображения SnackBar (например, "Заметка создана")
class NoteOperationSuccess extends NotesState {
  final String message;

  const NoteOperationSuccess(this.message);
}

class NotesError extends NotesState {
  final String message;

  const NotesError(this.message);
}
