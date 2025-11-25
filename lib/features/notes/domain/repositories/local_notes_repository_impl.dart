import 'package:treemov/features/notes/data/datasources/local_notes_datasource.dart';

import '../../domain/repositories/local_notes_repository.dart';

class LocalNotesRepositoryImpl implements LocalNotesRepository {
  final LocalNotesDataSource _dataSource;

  LocalNotesRepositoryImpl(this._dataSource);

  @override
  Future<List<String>> getPinnedNoteIds() => _dataSource.getPinnedNoteIds();

  @override
  Future<void> setPinnedStatus(String noteId, bool isPinned) =>
      _dataSource.setPinnedStatus(noteId, isPinned);
}
