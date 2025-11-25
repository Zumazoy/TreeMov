import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/features/notes/data/models/teacher_note_request_model.dart';
import 'package:treemov/features/notes/data/models/teacher_note_response_model.dart';
import 'package:treemov/features/notes/domain/entities/note_category_entity.dart';
import 'package:treemov/features/notes/domain/entities/teacher_note_entity.dart';
import 'package:treemov/features/notes/domain/repositories/local_notes_repository.dart'; // Импорт
import 'package:treemov/features/notes/domain/repositories/teacher_notes_repository.dart';
import 'package:treemov/shared/domain/repositories/shared_repository.dart';

import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final TeacherNotesRepository _notesRepository;
  final LocalNotesRepository _localNotesRepository; // Новая зависимость
  final SharedRepository _sharedRepository;

  int? _teacherId;

  NotesBloc(
    this._notesRepository,
    this._localNotesRepository,
    this._sharedRepository,
  ) : super(NotesInitial()) {
    on<LoadNotesEvent>(_onLoadNotes);
    on<CreateNoteEvent>(_onCreateNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onLoadNotes(
    LoadNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());
    try {
      _teacherId ??= await _sharedRepository.getTeacherId();

      // 1. Загружаем заметки с сервера
      final noteModels = await _notesRepository.getTeacherNotes();

      // 2. Загружаем список ID закрепленных заметок локально
      final pinnedIds = await _localNotesRepository.getPinnedNoteIds();

      // 3. Объединяем данные
      final notes = noteModels.map((model) {
        final entity = _mapToEntity(model);
        // Если ID заметки есть в локальном списке, ставим pinned = true
        if (pinnedIds.contains(entity.id)) {
          entity.isPinned = true;
        }
        return entity;
      }).toList();

      // Сортируем: Сначала закрепленные, потом по дате
      notes.sort((a, b) {
        if (a.isPinned != b.isPinned) {
          return a.isPinned ? -1 : 1;
        }
        return b.date.compareTo(a.date);
      });

      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError('Ошибка загрузки заметок: $e'));
    }
  }

  Future<void> _onCreateNote(
    CreateNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());
    try {
      _teacherId ??= await _sharedRepository.getTeacherId();

      final request = TeacherNoteRequestModel(
        title: event.title,
        text: event.content,
        category: event.category,
        // isPinned не отправляем на сервер, новые заметки по умолчанию не закреплены
        teacherProfileId: _teacherId!,
      );

      final createdNote = await _notesRepository.createTeacherNote(request);

      // Если пользователь выбрал "закрепить" при создании, сохраняем это локально
      if (event.isPinned) {
        await _localNotesRepository.setPinnedStatus(
          createdNote.id.toString(),
          true,
        );
      }

      emit(const NoteOperationSuccess('Заметка успешно создана'));
      add(LoadNotesEvent());
    } catch (e) {
      emit(NotesError('Ошибка создания заметки: $e'));
      add(LoadNotesEvent());
    }
  }

  Future<void> _onUpdateNote(
    UpdateNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());
    try {
      _teacherId ??= await _sharedRepository.getTeacherId();

      // 1. Обновляем локальный статус закрепления
      await _localNotesRepository.setPinnedStatus(event.id, event.isPinned);

      // 2. Отправляем изменения текста/категории на сервер
      final request = TeacherNoteRequestModel(
        title: event.title,
        text: event.content,
        category: event.category,
        teacherProfileId: _teacherId!,
      );

      final intId = int.tryParse(event.id) ?? 0;
      await _notesRepository.updateTeacherNote(intId, request);

      // emit(const NoteOperationSuccess('Заметка обновлена')); // Опционально
      add(LoadNotesEvent());
    } catch (e) {
      emit(NotesError('Ошибка обновления: $e'));
      add(LoadNotesEvent());
    }
  }

  Future<void> _onDeleteNote(
    DeleteNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesLoading());
    try {
      final intId = int.tryParse(event.id) ?? 0;

      // Удаляем с сервера
      await _notesRepository.deleteTeacherNote(intId);

      // Опционально: удаляем ID из локального хранилища, чтобы не мусорить
      await _localNotesRepository.setPinnedStatus(event.id, false);

      emit(const NoteOperationSuccess('Заметка удалена'));
      add(LoadNotesEvent());
    } catch (e) {
      emit(NotesError('Ошибка удаления: $e'));
      add(LoadNotesEvent());
    }
  }

  TeacherNoteEntity _mapToEntity(TeacherNoteResponseModel model) {
    final date =
        DateTime.tryParse(model.baseData.createdAt ?? '') ?? DateTime.now();
    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;

    return TeacherNoteEntity(
      id: model.id.toString(),
      title: model.title ?? '',
      content: model.text ?? '',
      date: date,
      category: NoteCategoryApiMapper.fromApi(model.category ?? ''),
      isPinned: false, // По умолчанию false, переопределяется в _onLoadNotes
      isToday: isToday,
    );
  }
}
