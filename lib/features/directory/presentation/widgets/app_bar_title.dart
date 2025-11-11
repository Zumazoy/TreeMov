import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class AppBarTitle extends StatelessWidget {
  final String text;

  const AppBarTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Arial',
        fontWeight: FontWeight.w900,
        fontSize: 20,
        height: 1.0,
        color: AppColors.grayFieldText,
      ),
    );
  }
}
