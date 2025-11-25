import 'package:shared_preferences/shared_preferences.dart';

class LocalNotesDataSource {
  static const _pinnedNotesKey = 'pinned_notes_ids';

  Future<List<String>> getPinnedNoteIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_pinnedNotesKey) ?? [];
  }

  Future<void> setPinnedStatus(String noteId, bool isPinned) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_pinnedNotesKey) ?? [];

    if (isPinned) {
      if (!ids.contains(noteId)) {
        ids.add(noteId);
      }
    } else {
      ids.remove(noteId);
    }

    await prefs.setStringList(_pinnedNotesKey, ids);
  }
}
