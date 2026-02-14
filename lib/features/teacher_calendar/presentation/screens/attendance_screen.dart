// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:treemov/core/widgets/layout/nav_bar.dart';
// import 'package:treemov/features/teacher_calendar/data/models/attendance_request_model.dart';
// import 'package:treemov/features/teacher_calendar/domain/entities/lesson_entity.dart';
// import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_bloc.dart';
// import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_event.dart';
// import 'package:treemov/features/teacher_calendar/presentation/bloc/schedules_state.dart';
// import 'package:treemov/shared/data/models/student_response_model.dart';
// import 'package:treemov/temp/main_screen.dart';

// import '../../../../core/themes/app_colors.dart';
// import '../widgets/attendance_parts/lesson_info_card.dart';
// import '../widgets/attendance_parts/statistics_row.dart';
// import '../widgets/attendance_parts/student_card.dart';

// class AttendanceScreen extends StatefulWidget {
//   final LessonEntity lesson;
//   final SchedulesBloc schedulesBloc;

//   const AttendanceScreen({
//     super.key,
//     required this.lesson,
//     required this.schedulesBloc,
//   });

//   @override
//   State<AttendanceScreen> createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   List<Map<String, dynamic>> _students = [];
//   bool _isLoading = false;
//   String? _errorMessage;
//   bool _isSaving = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadStudents();
//   }

//   void _loadStudents() {
//     if (widget.lesson.group?.id != null) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = null;
//       });

//       widget.schedulesBloc.add(
//         LoadStudentGroupByIdEvent(widget.lesson.group!.id!),
//       );
//     }
//   }

//   // Статистика
//   int get totalStudents => _students.length;
//   int get presentCount =>
//       _students.where((s) => s['attendance'] == 'present').length;
//   int get absentCount =>
//       _students.where((s) => s['attendance'] == 'absent').length;
//   int get notMarkedCount =>
//       _students.where((s) => s['attendance'] == 'not_marked').length;

//   // Проверка, можно ли сохранять
//   bool get canSaveAttendance => notMarkedCount == 0;

//   // Получаем данные о занятии из события
//   Map<String, dynamic> get _currentLesson {
//     final timeParts = widget.lesson
//         .formatTime(widget.lesson.startTime, widget.lesson.endTime)
//         .split('\n');
//     final startTime = timeParts.isNotEmpty ? timeParts[0] : '';
//     final endTime = timeParts.length > 1 ? timeParts[1] : '';

//     final groupName = widget.lesson.group?.title ?? '';
//     final formattedGroup = groupName.isNotEmpty
//         ? 'Группа "$groupName"'
//         : 'Группа не указана';

//     final subjectName = widget.lesson.subject?.title ?? '';
//     final formattedSubject = subjectName.isNotEmpty
//         ? subjectName
//         : 'Предмет не указан';

//     final classroomTitle = widget.lesson.classroom?.title ?? '';
//     final formattedClassroom = classroomTitle.isNotEmpty
//         ? classroomTitle
//         : 'Аудитория не указана';

//     final formattedTime = startTime.isNotEmpty && endTime.isNotEmpty
//         ? '$startTime-$endTime'
//         : 'Время не указано';

//     return {
//       'group': formattedGroup,
//       'subject': formattedSubject,
//       'time': formattedTime,
//       'classroom': formattedClassroom,
//     };
//   }

//   void _markAllPresent() {
//     setState(() {
//       for (var student in _students) {
//         student['attendance'] = 'present';
//       }
//     });
//   }

//   void _markPresent(int studentId) {
//     setState(() {
//       final student = _students.firstWhere((s) => s['id'] == studentId);
//       student['attendance'] = 'present';
//     });
//   }

//   void _markAbsent(int studentId) {
//     setState(() {
//       final student = _students.firstWhere((s) => s['id'] == studentId);
//       student['attendance'] = 'absent';
//     });
//   }

//   void _saveAttendance() {
//     if (!canSaveAttendance) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Пожалуйста, отметьте всех студентов перед сохранением ($notMarkedCount не отмечено)',
//           ),
//           backgroundColor: Colors.orange,
//           duration: Duration(seconds: 3),
//         ),
//       );
//       return;
//     }

//     if (widget.lesson.id == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Ошибка: ID занятия не указан'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() {
//       _isSaving = true;
//     });

//     // Создаем список запросов для всех студентов
//     final attendanceRequests = _students.map((student) {
//       return AttendanceRequestModel(
//         student: student['student']?.id ?? student['id'],
//         lesson: widget.lesson.id!,
//         wasPresent: student['attendance'] == 'present',
//       );
//     }).toList();

//     // Отправляем все запросы одним событием
//     widget.schedulesBloc.add(CreateMassAttendanceEvent(attendanceRequests));
//   }

//   void _onTabTapped(int index) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => MainScreen(initialIndex: index)),
//       (route) => false,
//     );
//   }

//   String _formatStudentName(StudentResponseModel student) {
//     final parts = [
//       student.surname,
//       student.name,
//     ].where((part) => part != null && part.isNotEmpty).toList();

//     return parts.isNotEmpty ? parts.join(' ') : 'Неизвестный студент';
//   }

//   // Сортируем студентов по фамилии и имени
//   List<Map<String, dynamic>> _getSortedStudents() {
//     return List.from(_students)..sort((a, b) {
//       final studentA = a['student'] as StudentResponseModel?;
//       final studentB = b['student'] as StudentResponseModel?;

//       if (studentA == null || studentB == null) return 0;

//       final surnameCompare = (studentA.surname ?? '').compareTo(
//         studentB.surname ?? '',
//       );
//       if (surnameCompare != 0) return surnameCompare;

//       return (studentA.name ?? '').compareTo(studentB.name ?? '');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double availableWidth = MediaQuery.of(context).size.width - 40;
//     final sortedStudents = _getSortedStudents();

//     return BlocListener<SchedulesBloc, ScheduleState>(
//       bloc: widget.schedulesBloc,
//       listener: (context, state) {
//         if (state is StudentGroupLoading) {
//           setState(() {
//             _isLoading = true;
//             _errorMessage = null;
//           });
//         } else if (state is StudentGroupLoaded) {
//           setState(() {
//             _isLoading = false;
//             _students = state.group.students.asMap().entries.map((entry) {
//               final student = entry.value;
//               final index = entry.key;
//               return {
//                 'id': student.id ?? index + 1,
//                 'name': _formatStudentName(student),
//                 'avatar': student.avatar ?? '',
//                 'attendance': 'not_marked',
//                 'student': student,
//               };
//             }).toList();
//           });
//         } else if (state is StudentGroupError) {
//           setState(() {
//             _isLoading = false;
//             _errorMessage = state.message;
//           });
//         } else if (state is AttendanceOperationSuccess) {
//           setState(() {
//             _isSaving = false;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'Посещаемость для "${_currentLesson['subject']}" сохранена',
//               ),
//               backgroundColor: Colors.green,
//             ),
//           );
//         } else if (state is AttendanceError) {
//           setState(() {
//             _isSaving = false;
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message), backgroundColor: Colors.red),
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.white,
//         appBar: AppBar(
//           backgroundColor: AppColors.white,
//           elevation: 0,
//           titleSpacing: 0,
//           title: Text(
//             'Посещаемость',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w900,
//               fontFamily: 'TT Norms',
//               color: Colors.black,
//             ),
//           ),
//           actions: [
//             if (_students.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(right: 16),
//                 child: ElevatedButton(
//                   onPressed: _markAllPresent,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.calendarButton,
//                     foregroundColor: AppColors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.5),
//                     ),
//                     elevation: 0,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 0,
//                     ),
//                   ),
//                   child: const Text(
//                     '+ отметить всех',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'TT Norms',
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Информация о занятии
//                 LessonInfoCard(
//                   lesson: _currentLesson,
//                   availableWidth: availableWidth,
//                 ),
//                 const SizedBox(height: 20),

//                 // Статистика
//                 StatisticsRow(
//                   availableWidth: availableWidth,
//                   totalStudents: totalStudents,
//                   presentCount: presentCount,
//                   absentCount: absentCount,
//                   notMarkedCount: notMarkedCount,
//                 ),
//                 const SizedBox(height: 30),

//                 Text(
//                   'Список обучающихся: ${_students.length}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     fontFamily: 'Arial',
//                     color: AppColors.grayFieldText,
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Список студентов
//                 if (_isLoading)
//                   _buildLoadingIndicator()
//                 else if (_errorMessage != null)
//                   _buildErrorState(_errorMessage!)
//                 else if (_students.isEmpty)
//                   _buildEmptyState()
//                 else
//                   Column(
//                     children: sortedStudents.map((student) {
//                       return StudentCard(
//                         student: student,
//                         availableWidth: availableWidth,
//                         onMarkPresent: () => _markPresent(student['id']),
//                         onMarkAbsent: () => _markAbsent(student['id']),
//                       );
//                     }).toList(),
//                   ),
//                 const SizedBox(height: 20),

//                 // Кнопка сохранения
//                 if (_students.isNotEmpty) _buildSaveButton(availableWidth),

//                 if (_students.isNotEmpty && !canSaveAttendance)
//                   _buildSaveHintText(),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: CustomBottomNavigationBar(
//           currentIndex: 0,
//           onTap: _onTabTapped,
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator() {
//     return SizedBox(
//       height: 100,
//       child: Center(
//         child: CircularProgressIndicator(color: AppColors.calendarButton),
//       ),
//     );
//   }

//   Widget _buildErrorState(String message) {
//     return SizedBox(
//       height: 100,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Ошибка загрузки студентов',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: AppColors.grayFieldText,
//                 fontFamily: 'TT Norms',
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               message,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.red,
//                 fontFamily: 'TT Norms',
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return SizedBox(
//       height: 100,
//       child: Center(
//         child: Text(
//           'В группе нет студентов',
//           style: TextStyle(
//             fontSize: 16,
//             color: AppColors.grayFieldText,
//             fontFamily: 'TT Norms',
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSaveButton(double availableWidth) {
//     return SizedBox(
//       width: availableWidth,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: _isSaving
//             ? null
//             : (canSaveAttendance ? _saveAttendance : null),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: canSaveAttendance && !_isSaving
//               ? AppColors.calendarButton
//               : AppColors.eventTap,
//           foregroundColor: canSaveAttendance && !_isSaving
//               ? AppColors.white
//               : AppColors.calendarButton,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.5),
//           ),
//           side: BorderSide(
//             color: canSaveAttendance && !_isSaving
//                 ? AppColors.calendarButton
//                 : AppColors.calendarButton,
//             width: 1,
//           ),
//           elevation: 0,
//           shadowColor: Colors.transparent,
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         ),
//         child: _isSaving
//             ? SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: AppColors.calendarButton,
//                 ),
//               )
//             : Text(
//                 canSaveAttendance
//                     ? 'Сохранить посещаемость'
//                     : 'Сохранить ($notMarkedCount не отмечено)',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'TT Norms',
//                   color: canSaveAttendance
//                       ? AppColors.white
//                       : AppColors.calendarButton,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//       ),
//     );
//   }

//   Widget _buildSaveHintText() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Center(
//         child: Text(
//           'Отметьте всех, чтобы сохранить',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             fontFamily: 'TT Norms',
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
