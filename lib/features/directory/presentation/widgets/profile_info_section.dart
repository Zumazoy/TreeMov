// import 'package:flutter/material.dart';
// import 'package:treemov/features/directory/presentation/screens/student_directory.dart';
// import 'package:treemov/shared/data/models/student_group_response_model.dart';
// import 'package:treemov/shared/domain/entities/student_entity.dart';

// import '../../../../../core/themes/app_colors.dart';

// class ProfileInfoSection extends StatelessWidget {
//   final StudentEntity student;
//   final List<StudentGroupResponseModel> allGroups;
//   final String currentGroupName;

//   const ProfileInfoSection({
//     super.key,
//     required this.student,
//     required this.allGroups,
//     required this.currentGroupName,
//   });

//   int _calculateAge(String? birthday) {
//     if (birthday == null) return 0;
//     try {
//       final birthDate = DateTime.parse(birthday);
//       final now = DateTime.now();
//       int age = now.year - birthDate.year;
//       if (now.month < birthDate.month ||
//           (now.month == birthDate.month && now.day < birthDate.day)) {
//         age--;
//       }
//       return age;
//     } catch (e) {
//       return 0;
//     }
//   }

//   String _formatDate(String? date) {
//     if (date == null) return 'Не указана';
//     try {
//       final dateTime = DateTime.parse(date);
//       return '${dateTime.day}.${dateTime.month}.${dateTime.year}';
//     } catch (e) {
//       return date;
//     }
//   }

//   // Находим все группы, в которых есть этот студент
//   List<StudentGroupResponseModel> _getOtherGroups() {
//     return allGroups.where((group) {
//       final hasStudent = group.students.any((s) => s.id == student.id);
//       final isCurrentGroup = group.title == currentGroupName;
//       return hasStudent && !isCurrentGroup;
//     }).toList();
//   }

//   void _onGroupTap(BuildContext context, StudentGroupResponseModel group) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) =>
//             StudentDirectoryScreen(group: group, allGroups: allGroups),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final age = _calculateAge(student.birthday);
//     final otherGroups = _getOtherGroups();

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.eventTap,
//         border: Border.all(color: AppColors.eventTap),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'День рождения: ',
//                         style: const TextStyle(
//                           fontFamily: 'Arial',
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12,
//                           height: 1.0,
//                           color: AppColors.directoryTextSecondary,
//                         ),
//                       ),
//                       TextSpan(
//                         text: _formatDate(student.birthday),
//                         style: const TextStyle(
//                           fontFamily: 'Arial',
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12,
//                           height: 1.0,
//                           color: AppColors.grayFieldText,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Text(
//                 '$age лет',
//                 style: const TextStyle(
//                   fontFamily: 'Arial',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 12,
//                   height: 1.0,
//                   color: AppColors.directoryTextSecondary,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'Номер телефона: ',
//                   style: const TextStyle(
//                     fontFamily: 'Arial',
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12,
//                     height: 1.0,
//                     color: AppColors.directoryTextSecondary,
//                   ),
//                 ),
//                 TextSpan(
//                   text: student.phoneNumber ?? 'Не указан',
//                   style: const TextStyle(
//                     fontFamily: 'Arial',
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12,
//                     height: 1.0,
//                     color: AppColors.grayFieldText,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),

//           const Text(
//             'Другие группы:',
//             style: TextStyle(
//               fontFamily: 'Arial',
//               fontWeight: FontWeight.w400,
//               fontSize: 12,
//               height: 1.0,
//               color: AppColors.directoryTextSecondary,
//             ),
//           ),
//           const SizedBox(height: 8),
//           if (otherGroups.isEmpty)
//             Text(
//               'Нет других групп',
//               style: TextStyle(
//                 fontFamily: 'Arial',
//                 fontWeight: FontWeight.w400,
//                 fontSize: 12,
//                 height: 1.0,
//                 color: AppColors.grayFieldText,
//               ),
//             )
//           else
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: otherGroups.map((group) {
//                 return GestureDetector(
//                   onTap: () => _onGroupTap(context, group),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: AppColors.directoryBorder),
//                     ),
//                     child: Text(
//                       group.title ?? 'Без названия',
//                       style: const TextStyle(
//                         fontFamily: 'Arial',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12,
//                         color: AppColors.grayFieldText,
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           const SizedBox(height: 12),

//           RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'Классный руководитель: ',
//                   style: const TextStyle(
//                     fontFamily: 'Arial',
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12,
//                     height: 1.0,
//                     color: AppColors.directoryTextSecondary,
//                   ),
//                 ),
//                 TextSpan(
//                   text: 'Не указан',
//                   style: const TextStyle(
//                     fontFamily: 'Arial',
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12,
//                     height: 1.0,
//                     color: AppColors.grayFieldText,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),

//           const Text(
//             'Контакты родителей:',
//             style: TextStyle(
//               fontFamily: 'Arial',
//               fontWeight: FontWeight.w400,
//               fontSize: 12,
//               height: 1.0,
//               color: AppColors.directoryTextSecondary,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Не указаны',
//             style: TextStyle(
//               fontFamily: 'Arial',
//               fontWeight: FontWeight.w400,
//               fontSize: 12,
//               height: 1.0,
//               color: AppColors.grayFieldText,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
