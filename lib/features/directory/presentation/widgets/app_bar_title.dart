import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_styles.dart';

class AppBarTitle extends StatelessWidget {
  final String text;

  const AppBarTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Text(
      text,
      style: AppTextStyles.arial20W700.copyWith(
        fontWeight: FontWeight.w900,
        color: isDark ? AppColors.darkText : AppColors.grayFieldText,
      ),
    );
  }
}
