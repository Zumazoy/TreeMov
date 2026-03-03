import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

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
        child: Text(text, style: AppTextStyles.arial16W500.primary),
      ),
    );
  }
}
