import 'package:flutter/material.dart';
import '../../domain/entities/teacher_note_entity.dart';
import '../../domain/entities/note_category_entity.dart';
import '../../../../core/themes/app_colors.dart';

class NoteCard extends StatelessWidget {
  final TeacherNoteEntity note;
  final VoidCallback onPinPressed;

  const NoteCard({super.key, required this.note, required this.onPinPressed});

  Color _getCategoryColor(NoteCategoryEntity category) {
    switch (category) {
      case NoteCategoryEntity.behavior:
        return const Color(0xFFDBEAFE);
      case NoteCategoryEntity.general:
        return const Color(0xFFFFEDD5);
      case NoteCategoryEntity.parents:
        return const Color(0xFFF3E8FF);
      case NoteCategoryEntity.study:
        return const Color(0xFFDCFCE7);
      case NoteCategoryEntity.all:
        return Colors.grey;
    }
  }

  Color _getCategoryTextColor(NoteCategoryEntity category) {
    switch (category) {
      case NoteCategoryEntity.behavior:
        return const Color(0xFF1E40AF);
      case NoteCategoryEntity.general:
        return const Color(0xFF9A3412);
      case NoteCategoryEntity.parents:
        return const Color(0xFF7E22CE);
      case NoteCategoryEntity.study:
        return const Color(0xFF166534);
      case NoteCategoryEntity.all:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      color: note.isPinned ? AppColors.eventTap : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: note.isPinned ? AppColors.teacherPrimary : AppColors.eventTap,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    color: note.isPinned
                        ? AppColors.teacherPrimary
                        : Colors.grey,
                  ),
                  onPressed: onPinPressed,
                ),

                // Контент заметки
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note.content,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${note.date.day}.${note.date.month}.${note.date.year}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Тег категории
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(note.category),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                note.category.title,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _getCategoryTextColor(note.category),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
