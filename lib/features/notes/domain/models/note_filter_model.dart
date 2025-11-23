import '../entities/note_category_entity.dart';

class NoteFilterModel {
  final List<NoteCategoryEntity> selectedCategories;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? quickFilter;
  final String searchTerm;

  const NoteFilterModel({
    this.selectedCategories = const [],
    this.startDate,
    this.endDate,
    this.quickFilter,
    this.searchTerm = '',
  });

  NoteFilterModel copyWith({
    List<NoteCategoryEntity>? selectedCategories,
    DateTime? startDate,
    DateTime? endDate,
    String? quickFilter,
    String? searchTerm,
    // Вспомогательные флаги для очистки фильтров
    bool clearStartDate = false,
    bool clearEndDate = false,
    bool clearQuickFilter = false,
  }) {
    return NoteFilterModel(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      startDate: clearStartDate ? null : startDate ?? this.startDate,
      endDate: clearEndDate ? null : endDate ?? this.endDate,
      quickFilter: clearQuickFilter ? null : quickFilter ?? this.quickFilter,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  // Подсчет активных фильтров (для UI)
  int get activeFiltersCount {
    int count = selectedCategories.length;
    if (startDate != null || endDate != null) count++;
    if (quickFilter != null) count++;
    if (searchTerm.isNotEmpty) count++;
    return count;
  }
}
