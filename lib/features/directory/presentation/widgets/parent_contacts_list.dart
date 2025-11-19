import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

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
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.2,
                          color: AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: contact.fullName,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.2,
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
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.2,
                          color: AppColors.directoryTextSecondary,
                        ),
                      ),
                      TextSpan(
                        text: contact.phone,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.2,
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
