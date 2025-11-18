import 'package:flutter/material.dart';
import '../../data/mocks/mock_notes_data.dart';
import '../../domain/entities/note_category_entity.dart';
import '../../domain/entities/teacher_note_entity.dart';
import '../widgets/category_filters.dart';
import '../widgets/notes_stats.dart';
import '../widgets/note_card.dart';
import '../widgets/create_note_modal.dart';
import '../../../directory/presentation/widgets/search_field.dart';
import '../../../../core/themes/app_colors.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  NoteCategoryEntity _selectedCategory = NoteCategoryEntity.all;
  final List<TeacherNoteEntity> _notes = MockNotesData.mockNotes;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<TeacherNoteEntity> get _filteredNotes {
    List<TeacherNoteEntity> filtered = _notes;

    if (_selectedCategory != NoteCategoryEntity.all) {
      filtered = filtered
          .where((note) => note.category == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (note) =>
                note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                note.content.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    return filtered;
  }

  List<TeacherNoteEntity> get _pinnedNotes =>
      _filteredNotes.where((note) => note.isPinned).toList();

  List<TeacherNoteEntity> get _normalNotes =>
      _filteredNotes.where((note) => !note.isPinned).toList();

  void _togglePin(TeacherNoteEntity note) {
    setState(() {
      note.togglePin();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _showCreateNoteModal() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: CreateNoteModal(
          onNoteCreated: (newNote) {
            setState(() {
              _notes.insert(0, newNote);
            });
          },
        ),
      );
    },
  );
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Заметки')),
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          SearchField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            hintText: 'Поиск заметок...',
          ),

          CategoryFilters(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: NotesStats(
              totalNotes: _filteredNotes.length,
              pinnedCount: _filteredNotes.where((note) => note.isPinned).length,
              todayCount: _filteredNotes.where((note) => note.isToday).length,
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                if (_pinnedNotes.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Закрепленные',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ..._pinnedNotes.map(
                    (note) => NoteCard(
                      note: note,
                      onPinPressed: () => _togglePin(note),
                    ),
                  ),
                ],

                if (_normalNotes.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Все заметки',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ..._normalNotes.map(
                    (note) => NoteCard(
                      note: note,
                      onPinPressed: () => _togglePin(note),
                    ),
                  ),
                ],

                if (_filteredNotes.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        'Заметки не найдены',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _showCreateNoteModal,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teacherPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                minimumSize: const Size(140, 48),
              ),
              child: const Text(
                'Новая заметка',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}