import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_styles.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Поиск...',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.arial14W400.copyWith(
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.directoryTextSecondary,
          ),
          filled: true,
          fillColor: isDark ? AppColors.darkCard : AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? AppColors.darkSurface : AppColors.directoryBorder,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? AppColors.darkSurface : AppColors.directoryBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? AppColors.darkText : AppColors.grayFieldText,
            ),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.directoryTextSecondary,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: AppTextStyles.arial14W400.copyWith(
          color: isDark ? AppColors.darkText : AppColors.grayFieldText,
        ),
      ),
    );
  }
}
