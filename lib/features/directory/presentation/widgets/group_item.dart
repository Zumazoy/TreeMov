import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_styles.dart';

class GroupItem extends StatefulWidget {
  final String groupName;
  final int studentCount;
  final VoidCallback onTap;

  const GroupItem({
    super.key,
    required this.groupName,
    required this.studentCount,
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
              widget.groupName,
              style: AppTextStyles.arial14W700.copyWith(
                color: AppColors.grayFieldText,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${widget.studentCount} учеников',
              style: AppTextStyles.arial12W400.grey,
            ),
            const Spacer(),
            Image.asset(
              'assets/images/purple_arrow.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
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
