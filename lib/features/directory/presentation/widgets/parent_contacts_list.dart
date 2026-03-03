import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_styles.dart';

class ParentContactsList extends StatelessWidget {
  static const List parentContacts = [''];

  const ParentContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...parentContacts.map((contact) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${contact.relationship}: ',
                        style: AppTextStyles.arial12W400.grey,
                      ),
                      TextSpan(
                        text: contact.fullName,
                        style: AppTextStyles.arial12W400.copyWith(
                          color: AppColors.grayFieldText,
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
                        style: AppTextStyles.arial12W400.grey,
                      ),
                      TextSpan(
                        text: contact.phone,
                        style: AppTextStyles.arial12W400.copyWith(
                          color: AppColors.grayFieldText,
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
