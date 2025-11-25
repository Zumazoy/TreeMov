import 'package:flutter/material.dart';
import '../../data/mocks/mock_notes_data.dart';
import '../../domain/entities/note_category_entity.dart';
import '../../domain/entities/teacher_note_entity.dart';
import '../widgets/category_filters.dart';
import '../widgets/notes_stats.dart';
import '../widgets/note_card.dart';
import '../widgets/create_note_modal.dart';
import '../widgets/edit_note_modal.dart';
import '../widgets/delete_note_modal.dart';
import '../widgets/filter_modal.dart';
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
  bool _isFilterActive = false;

  List<NoteCategoryEntity> _selectedCategories = [];
  DateTime? _startDate;
  DateTime? _endDate;
  String? _quickFilter;

  List<TeacherNoteEntity> get _filteredNotes {
    List<TeacherNoteEntity> filtered = _notes;

    if (_selectedCategory != NoteCategoryEntity.all) {
      filtered = filtered
          .where((note) => note.category == _selectedCategory)
          .toList();
    }

    if (_selectedCategories.isNotEmpty) {
      filtered = filtered
          .where((note) => _selectedCategories.contains(note.category))
          .toList();
    }

    if (_startDate != null || _endDate != null) {
      filtered = filtered.where((note) {
        bool matchesStart = true;
        bool matchesEnd = true;

        if (_startDate != null) {
          matchesStart = note.date.isAfter(
            _startDate!.subtract(const Duration(days: 1)),
          );
        }
        if (_endDate != null) {
          matchesEnd = note.date.isBefore(
            _endDate!.add(const Duration(days: 1)),
          );
        }

        return matchesStart && matchesEnd;
      }).toList();
    }

    if (_quickFilter != null) {
      final now = DateTime.now();
      switch (_quickFilter) {
        case 'Эта неделя':
          final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
          filtered = filtered
              .where(
                (note) => note.date.isAfter(
                  startOfWeek.subtract(const Duration(days: 1)),
                ),
              )
              .toList();
          break;
        case 'Месяц':
          final startOfMonth = DateTime(now.year, now.month, 1);
          filtered = filtered
              .where(
                (note) => note.date.isAfter(
                  startOfMonth.subtract(const Duration(days: 1)),
                ),
              )
              .toList();
          break;
        case 'Закрепленные':
          filtered = filtered.where((note) => note.isPinned).toList();
          break;
      }
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

  void _toggleFilter() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: FilterModal(
            initialSelectedCategories: _selectedCategories,
            initialStartDate: _startDate,
            initialEndDate: _endDate,
            initialQuickFilter: _quickFilter,
            allNotes: _notes,
            onApplyFilters:
                (
                  List<NoteCategoryEntity> selectedCategories,
                  DateTime? startDate,
                  DateTime? endDate,
                  String? quickFilter,
                ) {
                  setState(() {
                    _selectedCategories = selectedCategories;
                    _startDate = startDate;
                    _endDate = endDate;
                    _quickFilter = quickFilter;
                    _isFilterActive =
                        selectedCategories.isNotEmpty ||
                        startDate != null ||
                        endDate != null ||
                        quickFilter != null;
                  });
                },
          ),
        );
      },
    );
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

  void _editNote(TeacherNoteEntity note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: EditNoteModal(
            note: note,
            onNoteUpdated: (updatedNote) {
              setState(() {
                final index = _notes.indexWhere((n) => n.id == note.id);
                if (index != -1) {
                  _notes[index] = updatedNote;
                }
              });
            },
          ),
        );
      },
    );
  }

  void _deleteNote(TeacherNoteEntity note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: DeleteNoteModal(
          noteTitle: note.title,
          onDeletePressed: () {
            setState(() {
              _notes.remove(note);
            });
          },
        ),
      ),
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
      backgroundColor: AppColors.notesBackground,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    hintText: 'Поиск заметок...',
                  ),
                ),

                const SizedBox(width: 12),

                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _isFilterActive
                        ? AppColors.notesDarkText
                        : AppColors.white,
                    border: Border.all(color: AppColors.eventTap, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/funnel_icon.png',
                      width: 24,
                      height: 24,
                      color: _isFilterActive
                          ? AppColors.white
                          : AppColors.directoryTextSecondary,
                    ),
                    onPressed: _toggleFilter,
                  ),
                ),
              ],
            ),
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
                      onEditPressed: () => _editNote(note),
                      onDeletePressed: () => _deleteNote(note),
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
                      onEditPressed: () => _editNote(note),
                      onDeletePressed: () => _deleteNote(note),
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
