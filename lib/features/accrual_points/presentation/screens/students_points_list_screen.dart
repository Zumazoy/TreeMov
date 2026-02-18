// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:treemov/core/widgets/layout/nav_bar.dart';
// import 'package:treemov/features/accrual_points/presentation/bloc/accrual_bloc.dart';
// import 'package:treemov/shared/data/models/student_group_response_model.dart';
// import 'package:treemov/shared/data/models/student_response_model.dart';
// import 'package:treemov/shared/domain/entities/student_entity.dart';
// import 'package:treemov/temp/main_screen.dart';

// import '../../../../core/themes/app_colors.dart';
// import '../../../directory/presentation/widgets/search_field.dart';
// import '../../domain/entities/point_category_entity.dart';
// import '../widgets/action_selection_dialog.dart';
// import '../widgets/points_snackbar.dart';
// import '../widgets/student_avatar.dart';

// class StudentsPointsListScreen extends StatefulWidget {
//   final GroupStudentsResponseModel group;
//   final AccrualBloc accrualBloc;

//   const StudentsPointsListScreen({
//     super.key,
//     required this.group,
//     required this.accrualBloc,
//   });

//   @override
//   State<StudentsPointsListScreen> createState() =>
//       _StudentsPointsListScreenState();
// }

// class _StudentsPointsListScreenState extends State<StudentsPointsListScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<StudentResponseModel> _filteredStudents = [];
//   bool _hasSearchQuery = false;

//   List<StudentResponseModel> _getSortedStudents(
//     List<StudentResponseModel> students,
//   ) {
//     // Сортировка по фамилии, затем по имени
//     students.sort((a, b) {
//       final aSurname = a.surname ?? '';
//       final bSurname = b.surname ?? '';
//       final aName = a.name ?? '';
//       final bName = b.name ?? '';

//       final surnameCompare = aSurname.toLowerCase().compareTo(
//         bSurname.toLowerCase(),
//       );
//       if (surnameCompare != 0) return surnameCompare;
//       return aName.toLowerCase().compareTo(bName.toLowerCase());
//     });
//     return students;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _filteredStudents = _getSortedStudents(widget.group.students);
//   }

//   void _onSearchChanged(String query) {
//     setState(() {
//       _hasSearchQuery = query.isNotEmpty;

//       if (query.isEmpty) {
//         _filteredStudents = _getSortedStudents(widget.group.students);
//       } else {
//         _filteredStudents = _getSortedStudents(
//           widget.group.students.where((student) {
//             final fullName = '${student.name} ${student.surname}'.toLowerCase();
//             return fullName.contains(query.toLowerCase());
//           }).toList(),
//         );
//       }
//     });
//   }

//   void _showActionSelectionDialog(StudentEntity student) {
//     showDialog(
//       context: context,
//       builder: (context) => ActionSelectionDialog(
//         student: student,
//         accrualBloc: widget.accrualBloc,
//       ),
//     ).then((selectedAction) {
//       if (selectedAction != null) {
//         _showConfirmationScreen(student, selectedAction);
//       }
//     });
//   }

//   void _showConfirmationScreen(StudentEntity student, PointAction action) {
//     PointsSnackBar.show(context: context, student: student, action: action);
//   }

//   void _onTabTapped(int index) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => MainScreen(initialIndex: index)),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AccrualBloc, AccrualState>(
//       listener: (context, state) {
//         if (state is GroupsLoaded) {
//           setState(() {
//             final updatedGroup = state.groups.firstWhere(
//               (group) => group.baseData.id == widget.group.baseData.id,
//               orElse: () => widget.group, // если не нашли, используем старую
//             );
//             _filteredStudents = _getSortedStudents(updatedGroup.students);
//           });
//         }
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.white,
//         appBar: AppBar(
//           title: Text(
//             'Группа ${widget.group.title ?? "Без названия"}',
//             style: const TextStyle(
//               fontFamily: 'Arial',
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: AppColors.notesDarkText,
//             ),
//           ),
//           backgroundColor: AppColors.white,
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             SearchField(
//               controller: _searchController,
//               onChanged: _onSearchChanged,
//               hintText: 'Поиск ученика...',
//             ),
//             Expanded(child: _buildContent()),
//           ],
//         ),
//         bottomNavigationBar: CustomBottomNavigationBar(
//           currentIndex: 1,
//           onTap: _onTabTapped,
//         ),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     if (_hasSearchQuery && _filteredStudents.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.person_search,
//               size: 64,
//               color: AppColors.directoryTextSecondary,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Ученики не найдены',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.grayFieldText,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Попробуйте изменить поисковый запрос',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.directoryTextSecondary,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_filteredStudents.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.group_outlined,
//               size: 64,
//               color: AppColors.directoryTextSecondary,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'В группе нет учеников',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.grayFieldText,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Добавьте учеников в группу',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.directoryTextSecondary,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: _filteredStudents.length,
//       itemBuilder: (context, index) {
//         final student = _filteredStudents[index];
//         return _buildStudentCard(student.toEntity());
//       },
//     );
//   }

//   Widget _buildStudentCard(StudentEntity student) {
//     final attendancePercent = (0.8 * 100).toInt();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         border: Border.all(color: AppColors.directoryBorder),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           StudentAvatar(avatarUrl: student.avatar),
//           const SizedBox(width: 12),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${student.name} ${student.surname}',
//                   style: const TextStyle(
//                     fontFamily: 'Arial',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: AppColors.notesDarkText,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'посещаемость: $attendancePercent%',
//                   style: const TextStyle(
//                     fontFamily: 'Arial',
//                     fontWeight: FontWeight.normal,
//                     fontSize: 12,
//                     height: 1.0,
//                     color: AppColors.directoryTextSecondary,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Row(
//                   children: [
//                     Image.asset(
//                       'assets/images/energy_icon.png',
//                       width: 16,
//                       height: 16,
//                       color: AppColors.directoryTextSecondary,
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       '${student.score} баллов',
//                       style: const TextStyle(
//                         fontFamily: 'Arial',
//                         fontWeight: FontWeight.normal,
//                         fontSize: 12,
//                         height: 1.0,
//                         color: AppColors.directoryTextSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           Container(
//             height: 36,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               color: AppColors.teacherPrimary,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: TextButton.icon(
//               onPressed: () => _showActionSelectionDialog(student),
//               icon: const Icon(Icons.add, color: AppColors.white, size: 16),
//               label: const Text(
//                 'Начислить',
//                 style: TextStyle(
//                   fontFamily: 'Arial',
//                   fontSize: 12,
//                   color: AppColors.white,
//                 ),
//               ),
//               style: TextButton.styleFrom(
//                 padding: EdgeInsets.zero,
//                 minimumSize: Size.zero,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
