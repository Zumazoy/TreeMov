import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class RatingLoadingWidget extends StatelessWidget {
  const RatingLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.achievementDeepBlue),
    );
  }
}

class RatingErrorWidget extends StatelessWidget {
  final String message;

  const RatingErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Ошибка: $message',
        style: const TextStyle(
          color: AppColors.achievementDeepBlue,
          fontSize: 16,
        ),
      ),
    );
  }
}
