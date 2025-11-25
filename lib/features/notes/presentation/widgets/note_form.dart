import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/note_category_entity.dart';

class NoteForm extends StatefulWidget {
  final String title;
  final String buttonText;
  final String initialTitle;
  final String initialContent;
  final NoteCategoryEntity initialCategory;
  final bool initialIsPinned;
  final Function(
    String title,
    String content,
    NoteCategoryEntity category,
    bool isPinned,
  )
  onSubmit;

  const NoteForm({
    super.key,
    required this.title,
    required this.buttonText,
    this.initialTitle = '',
    this.initialContent = '',
    this.initialCategory = NoteCategoryEntity.general,
    this.initialIsPinned = false,
    required this.onSubmit,
  });

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late NoteCategoryEntity _selectedCategory;
  late bool _isPinned;

  bool get _isFormValid {
    return _titleController.text.trim().isNotEmpty &&
        _contentController.text.trim().isNotEmpty;
  }

  void _submitForm() {
    if (!_isFormValid) return;
    widget.onSubmit(
      _titleController.text,
      _contentController.text,
      _selectedCategory,
      _isPinned,
    );
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _contentController = TextEditingController(text: widget.initialContent);
    _selectedCategory = widget.initialCategory;
    _isPinned = widget.initialIsPinned;

    _titleController.addListener(_updateState);
    _contentController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateState);
    _contentController.removeListener(_updateState);
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              height: 1.0,
              color: AppColors.notesDarkText,
            ),
          ),
          const SizedBox(height: 8),

          // Кнопка "Закрепить"
          _buildPinButton(),
          const SizedBox(height: 24),

          // Поле "Заголовок"
          _buildTitleField(),
          const SizedBox(height: 16),

          // Поле "Категория"
          _buildCategoryField(),
          const SizedBox(height: 16),

          // Поле "Содержание"
          _buildContentField(),
          const SizedBox(height: 24),

          // Кнопки действий
          _buildActionButtons(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPinButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          setState(() {
            _isPinned = !_isPinned;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: _isPinned
              ? AppColors.teacherPrimary
              : AppColors.eventTap,
          foregroundColor: _isPinned ? Colors.white : AppColors.teacherPrimary,
          side: BorderSide(color: AppColors.teacherPrimary, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: Icon(
          _isPinned ? Icons.push_pin : Icons.push_pin_outlined,
          size: 16,
        ),
        label: const Text(
          'Закрепить',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Заголовок',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.0,
            color: AppColors.notesDarkText,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _titleController,
          style: const TextStyle(fontFamily: 'Arial'),
          decoration: InputDecoration(
            hintText: 'Введите заголовок...',
            hintStyle: const TextStyle(fontFamily: 'Arial'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.eventTap),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.eventTap),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.eventTap),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Категория',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.0,
            color: AppColors.notesDarkText,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<NoteCategoryEntity>(
          initialValue: _selectedCategory,
          items: NoteCategoryEntity.values
              .where((category) => category != NoteCategoryEntity.all)
              .map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(
                    category.title,
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      color: AppColors.notesDarkText,
                    ),
                  ),
                );
              })
              .toList(),
          onChanged: (category) {
            setState(() {
              _selectedCategory = category!;
            });
          },
          style: const TextStyle(
            fontFamily: 'Arial',
            color: AppColors.notesDarkText,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.eventTap),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.eventTap),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.eventTap),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Содержание',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.0,
            color: AppColors.notesDarkText,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _contentController,
          maxLines: 3,
          style: const TextStyle(fontFamily: 'Arial'),
          decoration: InputDecoration(
            hintText: 'Введите текст заметки...',
            hintStyle: const TextStyle(fontFamily: 'Arial'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.eventTap),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.eventTap),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.eventTap),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: const BorderSide(color: AppColors.eventTap),
            ),
            child: const Text(
              'Отмена',
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 1.0,
                color: AppColors.notesDarkText,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _isFormValid ? _submitForm : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isFormValid
                  ? AppColors.teacherPrimary
                  : AppColors.eventTap,
              foregroundColor: _isFormValid
                  ? Colors.white
                  : AppColors.teacherPrimary,
              side: BorderSide(color: AppColors.teacherPrimary, width: 1),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBackgroundColor: AppColors.eventTap,
              disabledForegroundColor: AppColors.teacherPrimary,
            ),
            child: Text(
              widget.buttonText,
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
