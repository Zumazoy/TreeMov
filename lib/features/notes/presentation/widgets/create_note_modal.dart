import 'package:flutter/material.dart';
import '../../domain/entities/note_category_entity.dart';
import '../../domain/entities/teacher_note_entity.dart';
import '../../../../core/themes/app_colors.dart';

class CreateNoteModal extends StatefulWidget {
  final Function(TeacherNoteEntity) onNoteCreated;

  const CreateNoteModal({super.key, required this.onNoteCreated});

  @override
  State<CreateNoteModal> createState() => _CreateNoteModalState();
}

class _CreateNoteModalState extends State<CreateNoteModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  NoteCategoryEntity _selectedCategory = NoteCategoryEntity.general;

  void _createNote() {
    if (_titleController.text.isEmpty) return;

    final newNote = TeacherNoteEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now(),
      category: _selectedCategory,
      isPinned: false,
      isToday: true,
    );

    widget.onNoteCreated(newNote);
    Navigator.pop(context);

    _titleController.clear();
    _contentController.clear();
    _selectedCategory = NoteCategoryEntity.general;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Новая заметка',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 24),

          const Text(
            'Заголовок',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Введите заголовок...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Категория',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<NoteCategoryEntity>(
            initialValue: _selectedCategory,
            items: NoteCategoryEntity.values
                .where((category) => category != NoteCategoryEntity.all)
                .map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.title),
                  );
                })
                .toList(),
            onChanged: (category) {
              setState(() {
                _selectedCategory = category!;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Содержание',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _contentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Введите текст заметки...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _createNote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teacherPrimary,
                  ),
                  child: const Text('Создать'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
