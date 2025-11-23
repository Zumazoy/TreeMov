abstract class LocalNotesRepository {
  Future<List<String>> getPinnedNoteIds();
  Future<void> setPinnedStatus(String noteId, bool isPinned);
}
