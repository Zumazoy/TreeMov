import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_styles.dart';

class ParentContactsList extends StatelessWidget {
  final List<Map<String, String>> contacts;

  const ParentContactsList({super.key, this.contacts = const []});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (contacts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...contacts.map((contact) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${contact['relationship'] ?? 'Родитель'}: ',
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: contact['fullName'] ?? '',
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.grayFieldText,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Номер: ',
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: contact['phone'] ?? '',
                        style: AppTextStyles.arial12W400.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.grayFieldText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
