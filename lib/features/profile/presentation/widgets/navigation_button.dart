import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const NavigationButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Arial',
            color: AppColors.teacherPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
