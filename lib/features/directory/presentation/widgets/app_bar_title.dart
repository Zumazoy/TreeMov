import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_styles.dart';

class AppBarTitle extends StatelessWidget {
  final String text;

  const AppBarTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.arial20W700.copyWith(
        fontWeight: FontWeight.w900,
        color: AppColors.grayFieldText,
      ),
    );
  }
}
