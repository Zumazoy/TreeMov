import 'package:flutter/material.dart';
import 'package:treemov/features/directory/domain/entities/group_entity.dart';
import 'package:treemov/features/directory/domain/entities/subject_entity.dart';

import '../../../../../core/themes/app_colors.dart';

class GroupItem extends StatefulWidget {
  final GroupEntity group;
  final SubjectEntity subject;
  final VoidCallback onTap;

  const GroupItem({
    super.key,
    required this.group,
    required this.subject,
    required this.onTap,
  });

  @override
  State<GroupItem> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
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
            Text(
              '${widget.subject.name}  ',
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                height: 1.0,
                color: AppColors.grayFieldText,
              ),
            ),
            Text(
              'Группа: ${widget.group.name}  ',
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.0,
                color: AppColors.directoryTextSecondary,
              ),
            ),
            Text(
              '${widget.group.studentCount} учеников',
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.0,
                color: AppColors.directoryTextSecondary,
              ),
            ),
            const Spacer(),
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
