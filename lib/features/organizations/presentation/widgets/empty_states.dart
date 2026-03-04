import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

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
          Text(
            'Ничего не найдено',
            style: AppTextStyles.ttNorms16W700.copyWith(
              color: AppColors.grayFieldText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Попробуйте изменить поисковый запрос',
            style: AppTextStyles.ttNorms14W400.grey,
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
          Text(
            'Нет организаций',
            style: AppTextStyles.ttNorms16W700.copyWith(
              color: AppColors.grayFieldText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Создайте первую организацию и примите приглашение',
            style: AppTextStyles.ttNorms14W400.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
