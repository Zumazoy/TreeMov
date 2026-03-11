import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/core/themes/app_text_styles.dart';

class EmptySearchView extends StatelessWidget {
  const EmptySearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.directoryTextSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Ничего не найдено',
            style: AppTextStyles.ttNorms16W700.copyWith(
              color: isDark ? AppColors.darkText : AppColors.grayFieldText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Попробуйте изменить поисковый запрос',
            style: AppTextStyles.ttNorms14W400.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.directoryTextSecondary,
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business_outlined,
            size: 64,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.directoryTextSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Нет организаций',
            style: AppTextStyles.ttNorms16W700.copyWith(
              color: isDark ? AppColors.darkText : AppColors.grayFieldText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Создайте первую организацию и примите приглашение',
            style: AppTextStyles.ttNorms14W400.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.directoryTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
