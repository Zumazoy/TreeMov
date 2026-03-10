import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class RatingLoadingWidget extends StatelessWidget {
  const RatingLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
