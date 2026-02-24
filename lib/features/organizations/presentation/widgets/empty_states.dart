import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class EmptySearchView extends StatelessWidget {
  const EmptySearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.directoryTextSecondary,
          ),
          const SizedBox(height: 16),
          const Text(
            'Ничего не найдено',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.grayFieldText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Попробуйте изменить поисковый запрос',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.directoryTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyOrganizationsView extends StatelessWidget {
  const EmptyOrganizationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.business_outlined,
            size: 64,
            color: AppColors.directoryTextSecondary,
          ),
          const SizedBox(height: 16),
          const Text(
            'Нет организаций',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.grayFieldText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Создайте первую организацию и примите приглашение',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.directoryTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
