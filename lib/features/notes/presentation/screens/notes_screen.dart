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
// Используем существующие виджеты
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
      // Инициализируем Bloc и сразу загружаем заметки
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

  // Состояние фильтров храним локально в виджете, данные - в Bloc
  String _searchQuery = '';
  bool _isFilterActive = false;
  List<NoteCategoryEntity> _selectedCategories = [];
  DateTime? _startDate;
  DateTime? _endDate;
  String? _quickFilter;

  // Локальный список для отображения (фильтруется из стейта Bloc)
  List<TeacherNoteEntity> _filterNotes(List<TeacherNoteEntity> allNotes) {
    List<TeacherNoteEntity> filtered = allNotes;

    // Фильтр по табам категорий
    if (_selectedCategory != NoteCategoryEntity.all) {
      filtered = filtered
          .where((note) => note.category == _selectedCategory)
          .toList();
    }

    // Расширенные фильтры
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
    // Поскольку API не поддерживает pin, мы обновляем через UpdateNoteEvent,
    // чтобы сохранить консистентность, хотя бэкенд может игнорировать это поле.
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
              // Отправляем событие в Bloc
              // Используем context родительского виджета, поэтому modalContext тут не нужен для bloc
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
      appBar: AppBar(title: const Text('Заметки')),
      backgroundColor: AppColors.notesBackground,
      // Слушаем изменения состояния для показа SnackBar
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
          // Получаем актуальный список заметок из состояния или пустой список
          List<TeacherNoteEntity> allNotes = [];
          if (state is NotesLoaded) {
            allNotes = state.notes;
          } else if (state is NoteOperationSuccess) {
            // Если операция успешна, можно перезапросить или использовать предыдущий стейт,
            // но обычно Bloc переходит обратно в Loaded после обновления.
            // В нашем Bloc мы делаем add(LoadNotesEvent()) после операций,
            // так что мы снова попадем в Loading -> Loaded.
          }

          final filteredList = _filterNotes(allNotes);
          final pinnedNotes = filteredList.where((n) => n.isPinned).toList();
          final normalNotes = filteredList.where((n) => !n.isPinned).toList();

          return Column(
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
                        onPressed: () => _toggleFilter(allNotes),
                      ),
                    ),
                  ],
                ),
              ),

              CategoryFilters(
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() => _selectedCategory = category);
                },
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: NotesStats(
                  totalNotes: filteredList.length,
                  pinnedCount: pinnedNotes.length,
                  todayCount: filteredList.where((n) => n.isToday).length,
                ),
              ),

              Expanded(
                child: state is NotesLoading && allNotes.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView(
                        children: [
                          if (pinnedNotes.isNotEmpty) ...[
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
                              padding: EdgeInsets.all(16.0),
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
          );
        },
      ),
    );
  }
}
