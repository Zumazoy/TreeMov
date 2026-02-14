// import 'package:flutter/material.dart';
// import 'package:treemov/features/directory/presentation/screens/student_profile.dart';
// import 'package:treemov/features/directory/presentation/widgets/app_bar_title.dart';
// import 'package:treemov/features/directory/presentation/widgets/search_field.dart';
// import 'package:treemov/features/directory/presentation/widgets/student_item.dart';
// import 'package:treemov/shared/data/models/student_group_response_model.dart';
// import 'package:treemov/shared/data/models/student_response_model.dart';
// import 'package:treemov/shared/domain/entities/student_entity.dart';
// import 'package:treemov/temp/main_screen.dart';

// import '../../../../../core/themes/app_colors.dart';
// import '../../../../../core/widgets/layout/nav_bar.dart';

// class StudentDirectoryScreen extends StatefulWidget {
//   final StudentGroupResponseModel group;
//   final List<StudentGroupResponseModel> allGroups;

//   const StudentDirectoryScreen({
//     super.key,
//     required this.group,
//     required this.allGroups,
//   });

//   @override
//   State<StudentDirectoryScreen> createState() => _StudentDirectoryScreenState();
// }

// class _StudentDirectoryScreenState extends State<StudentDirectoryScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<StudentResponseModel> _filteredStudents = [];

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

//   void _onStudentTap(StudentEntity student) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => StudentProfileScreen(
//           student: student,
//           groupName: widget.group.title ?? 'Группа',
//           allGroups: widget.allGroups,
//         ),
//       ),
//     );
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
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         title: AppBarTitle(text: 'Ученики ${widget.group.title}'),
//         backgroundColor: AppColors.white,
//         foregroundColor: AppColors.grayFieldText,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           SearchField(
//             controller: _searchController,
//             onChanged: _onSearchChanged,
//             hintText: 'Найти: по группам, ученикам...',
//           ),
//           Expanded(
//             child:
//                 _filteredStudents.isEmpty && _searchController.text.isNotEmpty
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                           Icons.person_search,
//                           size: 64,
//                           color: AppColors.directoryTextSecondary,
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'Студенты не найдены',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.grayFieldText,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Попробуйте изменить поисковый запрос',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: AppColors.directoryTextSecondary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : ListView(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     children: [
//                       ..._filteredStudents.map(
//                         (student) => StudentItem(
//                           student: student.toEntity(),
//                           groupName: widget.group.title ?? 'Группа',
//                           onTap: () => _onStudentTap(student.toEntity()),
//                         ),
//                       ),
//                     ],
//                   ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: 2,
//         onTap: _onTabTapped,
//       ),
//     );
//   }
// }
