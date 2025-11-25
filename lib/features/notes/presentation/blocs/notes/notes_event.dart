import 'package:equatable/equatable.dart';
import 'package:treemov/features/notes/domain/entities/note_category_entity.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

// Загрузка списка заметок
class LoadNotesEvent extends NotesEvent {}

// Создание заметки
class CreateNoteEvent extends NotesEvent {
  final String title;
  final String content;
  final NoteCategoryEntity category;
  final bool
  isPinned; // API может не поддерживать, но передаем для локальной логики

  const CreateNoteEvent({
    required this.title,
    required this.content,
    required this.category,
    required this.isPinned,
  });

  @override
  List<Object?> get props => [title, content, category, isPinned];
}

// Обновление заметки
class UpdateNoteEvent extends NotesEvent {
  final String id;
  final String title;
  final String content;
  final NoteCategoryEntity category;
  final bool isPinned;

  const UpdateNoteEvent({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.isPinned,
  });

  @override
  List<Object?> get props => [id, title, content, category, isPinned];
}

// Удаление заметки
class DeleteNoteEvent extends NotesEvent {
  final String id;

  const DeleteNoteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
