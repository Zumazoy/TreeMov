import 'package:flutter/material.dart';
import 'package:treemov/features/directory/data/mocks/mock_directory_data.dart';
import 'package:treemov/features/directory/domain/entities/student_entity.dart';

import '../../../../../core/themes/app_colors.dart';
import 'group_chips.dart';
import 'parent_contacts_list.dart';

class ProfileInfoSection extends StatelessWidget {
  final StudentEntity student;

  const ProfileInfoSection({super.key, required this.student});

  String _getClassTeacherName(String teacherId) {
    if (teacherId == MockDirectoryData.classTeacher.id) {
      return MockDirectoryData.classTeacher.fullName;
    }
    return 'Неизвестно';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.eventTap,
        border: Border.all(color: AppColors.eventTap),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'День рождения: ',
                      style: const TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.0,
                        color: AppColors.directoryTextSecondary,
                      ),
                    ),
                    TextSpan(
                      text: student.formattedBirthDate,
                      style: const TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.0,
                        color: AppColors.grayFieldText,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '${student.age} лет',
                style: const TextStyle(
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.0,
                  color: AppColors.grayFieldText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Номер телефона: ',
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.0,
                    color: AppColors.directoryTextSecondary,
                  ),
                ),
                TextSpan(
                  text: student.phone,
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.0,
                    color: AppColors.grayFieldText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            'Другие группы:',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.0,
              color: AppColors.directoryTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          GroupChips(groupIds: student.otherGroupIds),
          const SizedBox(height: 12),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Классный руководитель: ',
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.0,
                    color: AppColors.directoryTextSecondary,
                  ),
                ),
                TextSpan(
                  text: _getClassTeacherName(student.classTeacherId),
                  style: const TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.0,
                    color: AppColors.grayFieldText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            'Контакты родителей:',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.0,
              color: AppColors.directoryTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          ParentContactsList(parentContacts: student.parentContacts),
        ],
      ),
    );
  }
}
