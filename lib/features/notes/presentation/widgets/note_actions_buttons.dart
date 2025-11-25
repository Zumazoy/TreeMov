import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class NoteActionsButtons extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const NoteActionsButtons({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.teacherPrimary, width: 1),
          ),
          child: IconButton(
            icon: Image.asset(
              'assets/images/note_change_icon.png',
              width: 16,
              height: 16,
            ),
            onPressed: onEditPressed,
            padding: EdgeInsets.zero,
            iconSize: 16,
          ),
        ),
        const SizedBox(width: 8),

        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFDF9594), width: 1),
          ),
          child: IconButton(
            icon: Image.asset(
              'assets/images/bin_icon.png',
              width: 16,
              height: 16,
            ),
            onPressed: onDeletePressed,
            padding: EdgeInsets.zero,
            iconSize: 16,
          ),
        ),
      ],
    );
  }
}
