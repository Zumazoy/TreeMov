import 'package:flutter/material.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

import '../../../../../core/themes/app_colors.dart';

class StudentItem extends StatefulWidget {
  final StudentEntity student;
  final String groupName;
  final VoidCallback onTap;

  const StudentItem({
    super.key,
    required this.student,
    required this.groupName,
    required this.onTap,
  });

  @override
  State<StudentItem> createState() => _StudentItemState();
}

class _StudentItemState extends State<StudentItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isPressed ? AppColors.eventTap : AppColors.white,
          border: Border.all(
            color: _isPressed ? AppColors.eventTap : AppColors.directoryBorder,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Аватарка
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.directoryAvatarBackground,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: AppColors.directoryAvatarBorder,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.directoryTextSecondary,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            // Имя и группа
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.student.name ?? ''} ${widget.student.surname ?? ''}',
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      height: 1.0,
                      color: AppColors.grayFieldText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Группа: ${widget.groupName}',
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.0,
                      color: AppColors.directoryTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Стрелочка
            Image.asset(
              'assets/images/purple_arrow.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.grayFieldText,
                  size: 20,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
