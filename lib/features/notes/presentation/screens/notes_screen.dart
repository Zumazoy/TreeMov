import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/notes/presentation/blocs/notes/notes_bloc.dart';
import 'package:treemov/features/notes/presentation/blocs/notes/notes_event.dart';
import 'package:treemov/features/notes/presentation/blocs/notes/notes_state.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../directory/presentation/widgets/search_field.dart';
import '../../domain/entities/note_category_entity.dart';
import '../../domain/entities/teacher_note_entity.dart';
import '../widgets/category_filters.dart';
import '../widgets/create_note_modal.dart';
import '../widgets/delete_note_modal.dart';
import '../widgets/edit_note_modal.dart';
import '../widgets/filter_modal.dart';
import '../widgets/note_card.dart';
import '../widgets/notes_stats.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotesBloc>()..add(LoadNotesEvent()),
      child: const _NotesScreenContent(),
    );
  }
}

class _NotesScreenContent extends StatefulWidget {
  const _NotesScreenContent();

  @override
  State<_NotesScreenContent> createState() => _NotesScreenContentState();
}

class _NotesScreenContentState extends State<_NotesScreenContent> {
  NoteCategoryEntity _selectedCategory = NoteCategoryEntity.all;
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  bool _isFilterActive = false;
  List<NoteCategoryEntity> _selectedCategories = [];
  DateTime? _startDate;
  DateTime? _endDate;
  String? _quickFilter;

  List<TeacherNoteEntity> _filterNotes(List<TeacherNoteEntity> allNotes) {
    List<TeacherNoteEntity> filtered = allNotes;

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

  void _togglePin(TeacherNoteEntity note) {
    context.read<NotesBloc>().add(
      UpdateNoteEvent(
        id: note.id,
        title: note.title,
        content: note.content,
        category: note.category,
        isPinned: !note.isPinned,
      ),
    );
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _toggleFilter(List<TeacherNoteEntity> currentNotes) {
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
            allNotes: currentNotes,
            onApplyFilters:
                (selectedCategories, startDate, endDate, quickFilter) {
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
              this.context.read<NotesBloc>().add(
                CreateNoteEvent(
                  title: newNote.title,
                  content: newNote.content,
                  category: newNote.category,
                  isPinned: newNote.isPinned,
                ),
              );
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
              this.context.read<NotesBloc>().add(
                UpdateNoteEvent(
                  id: updatedNote.id,
                  title: updatedNote.title,
                  content: updatedNote.content,
                  category: updatedNote.category,
                  isPinned: updatedNote.isPinned,
                ),
              );
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
            this.context.read<NotesBloc>().add(DeleteNoteEvent(note.id));
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
      backgroundColor: AppColors.notesBackground,
      appBar: AppBar(
        backgroundColor: AppColors.notesBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false, // Заголовок слева
        title: Row(
          children: [
            const Icon(
              Icons.description_outlined,
              color: AppColors.notesDarkText,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Заметки',
              style: TextStyle(
                fontFamily: 'TT Norms',
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: AppColors.notesDarkText,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              width: 40,
              height: 40,
              child: ElevatedButton(
                onPressed: _showCreateNoteModal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.teacherPrimary, // Фиолетовый цвет
                  foregroundColor: Colors.white, // Цвет иконки/сплэша
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Скругление
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: const Icon(Icons.add, size: 28, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NoteOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is NotesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          List<TeacherNoteEntity> allNotes = [];
          if (state is NotesLoaded) {
            allNotes = state.notes;
          }

          final filteredList = _filterNotes(allNotes);
          final pinnedNotes = filteredList.where((n) => n.isPinned).toList();
          final normalNotes = filteredList.where((n) => !n.isPinned).toList();

          return Column(
            children: [
              // Поле поиска и кнопка фильтра
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
                        onPressed: () => _toggleFilter(allNotes),
                      ),
                    ),
                  ],
                ),
              ),

              // Категории (табы)
              CategoryFilters(
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() => _selectedCategory = category);
                },
              ),

              // Статистика
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: NotesStats(
                  totalNotes: filteredList.length,
                  pinnedCount: pinnedNotes.length,
                  todayCount: filteredList.where((n) => n.isToday).length,
                ),
              ),

              // Список заметок
              Expanded(
                child: state is NotesLoading && allNotes.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        padding: const EdgeInsets.only(bottom: 20),
                        children: [
                          if (pinnedNotes.isNotEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                'Закрепленные',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ...pinnedNotes.map(
                              (note) => NoteCard(
                                note: note,
                                onPinPressed: () => _togglePin(note),
                                onEditPressed: () => _editNote(note),
                                onDeletePressed: () => _deleteNote(note),
                              ),
                            ),
                          ],
                          if (normalNotes.isNotEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                'Все заметки',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ...normalNotes.map(
                              (note) => NoteCard(
                                note: note,
                                onPinPressed: () => _togglePin(note),
                                onEditPressed: () => _editNote(note),
                                onDeletePressed: () => _deleteNote(note),
                              ),
                            ),
                          ],
                          if (filteredList.isEmpty && state is! NotesLoading)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: Text(
                                  'Заметки не найдены',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
