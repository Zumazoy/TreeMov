import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../domain/entities/note_category_entity.dart';
import '../../domain/entities/teacher_note_entity.dart';
import 'note_actions_buttons.dart';

class NoteCard extends StatelessWidget {
  final TeacherNoteEntity note;
  final VoidCallback onPinPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const NoteCard({
    super.key,
    required this.note,
    required this.onPinPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  Color _getCategoryColor(NoteCategoryEntity category) {
    switch (category) {
      case NoteCategoryEntity.behavior:
        return AppColors.categoryBehaviorBg;
      case NoteCategoryEntity.general:
        return AppColors.categoryGeneralBg;
      case NoteCategoryEntity.parents:
        return AppColors.categoryParentsBg;
      case NoteCategoryEntity.study:
        return AppColors.categoryStudyBg;
      case NoteCategoryEntity.all:
        return Colors.grey;
    }
  }

  Color _getCategoryTextColor(NoteCategoryEntity category) {
    switch (category) {
      case NoteCategoryEntity.behavior:
        return AppColors.categoryBehaviorText;
      case NoteCategoryEntity.general:
        return AppColors.categoryGeneralText;
      case NoteCategoryEntity.parents:
        return AppColors.categoryParentsText;
      case NoteCategoryEntity.study:
        return AppColors.categoryStudyText;
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
            padding: const EdgeInsets.only(
              left: 16,
              right: 80,
              top: 16,
              bottom: 16,
            ),
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

          Positioned(
            top: 40,
            right: 12,
            child: NoteActionsButtons(
              onEditPressed: onEditPressed,
              onDeletePressed: onDeletePressed,
            ),
          ),
        ],
      ),
    );
  }
}
