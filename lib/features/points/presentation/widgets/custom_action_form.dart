import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class CustomActionForm extends StatefulWidget {
  final Function(String, String, int) onSave;
  final Function() onCancel;

  const CustomActionForm({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<CustomActionForm> createState() => _CustomActionFormState();
}

class _CustomActionFormState extends State<CustomActionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final FocusNode _pointsFocusNode = FocusNode();

  void _onSave() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final points = int.tryParse(_pointsController.text) ?? 0;

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите заголовок действия')),
      );
      return;
    }

    widget.onSave(title, description, points);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.teacherPrimary, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Создать свое действие',
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColors.notesDarkText,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Заголовок действия',
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
                  borderSide: const BorderSide(color: AppColors.teacherPrimary),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                labelStyle: const TextStyle(
                  fontFamily: 'Arial',
                  color: AppColors.grayFieldText,
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: AppColors.notesDarkText,
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Описание (необязательно)',
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
                  borderSide: const BorderSide(color: AppColors.teacherPrimary),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                labelStyle: const TextStyle(
                  fontFamily: 'Arial',
                  color: AppColors.grayFieldText,
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: AppColors.notesDarkText,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _pointsController,
              focusNode: _pointsFocusNode,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Количество баллов',
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
                  borderSide: const BorderSide(color: AppColors.teacherPrimary),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                labelStyle: const TextStyle(
                  fontFamily: 'Arial',
                  color: AppColors.grayFieldText,
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: AppColors.notesDarkText,
              ),
            ),
            const SizedBox(height: 8),

            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                'Введите число баллов',
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 11,
                  color: AppColors.grayFieldText,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.notesDarkText,
                      side: const BorderSide(color: AppColors.eventTap),
                      backgroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Отмена',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teacherPrimary,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
