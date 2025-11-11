// import 'package:flutter/material.dart';
// import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';

// class ScheduleDetailScreen extends StatelessWidget {
//   final ScheduleResponseModel schedule;

//   const ScheduleDetailScreen({super.key, required this.schedule});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Занятие #${schedule.id}')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           _buildInfoCard('Основная информация', [
//             _buildInfoRow('ID', schedule.id.toString()),
//             _buildInfoRow(
//               'Название',
//               schedule.title.isEmpty ? '(Без названия)' : schedule.title,
//             ),
//             _buildInfoRow('Дата', schedule.formattedDate),
//             _buildInfoRow('День недели', schedule.weekDayName),
//             if (schedule.lesson != null)
//               _buildInfoRow('Номер урока', schedule.lesson.toString()),
//           ]),

//           const SizedBox(height: 16),

//           _buildInfoCard('Время', [
//             if (schedule.startTime != null)
//               _buildInfoRow('Время начала', _formatTime(schedule.startTime!)),
//             if (schedule.endTime != null)
//               _buildInfoRow('Время окончания', _formatTime(schedule.endTime!)),
//             if (schedule.duration != null)
//               _buildInfoRow('Продолжительность', schedule.duration!),
//             if (schedule.startTime == null && schedule.endTime == null)
//               _buildInfoRow('Время', 'Не указано'),
//           ]),

//           const SizedBox(height: 16),

//           _buildInfoCard('Преподаватель', [
//             _buildInfoRow('ID преподавателя', schedule.teacherId.toString()),
//             _buildInfoRow('Организация', schedule.teacherOrg.toString()),
//             if (schedule.teacherCreatedAt != null)
//               _buildInfoRow(
//                 'Создан',
//                 _formatDateTime(schedule.teacherCreatedAt!),
//               ),
//           ]),

//           const SizedBox(height: 16),

//           _buildInfoCard('Сотрудник (Employer)', [
//             _buildInfoRow('ID сотрудника', schedule.employerId.toString()),
//             _buildInfoRow('Фамилия', schedule.employerSurname),
//             _buildInfoRow('Имя', schedule.employerName),
//             if (schedule.employerPatronymic != null)
//               _buildInfoRow('Отчество', schedule.employerPatronymic!),
//             _buildInfoRow('Полное ФИО', schedule.formattedEmployer),
//             if (schedule.employerEmail != null)
//               _buildInfoRow('Email', schedule.employerEmail!),
//             if (schedule.employerBirthday != null)
//               _buildInfoRow(
//                 'Дата рождения',
//                 _formatDate(schedule.employerBirthday!),
//               ),
//             if (schedule.employerInn != null)
//               _buildInfoRow('ИНН', schedule.employerInn!),
//             if (schedule.employerPassportSeries != null)
//               _buildInfoRow('Серия паспорта', schedule.employerPassportSeries!),
//             if (schedule.employerPassportNum != null)
//               _buildInfoRow('Номер паспорта', schedule.employerPassportNum!),
//             _buildInfoRow('Организация', schedule.employerOrg.toString()),
//             if (schedule.employerDepartment != null)
//               _buildInfoRow('Отдел', schedule.employerDepartment.toString()),
//             if (schedule.formattedEmployerCreatedAt != null)
//               _buildInfoRow('Создан', schedule.formattedEmployerCreatedAt!),
//           ]),

//           const SizedBox(height: 16),

//           _buildInfoCard('Предмет', [
//             _buildInfoRow('ID', schedule.subjectId.toString()),
//             _buildInfoRow('Название', schedule.subjectName),
//             if (schedule.subjectColor != null)
//               _buildInfoRow('Цвет', schedule.subjectColor!),
//             _buildInfoRow('Организация', schedule.subjectOrg.toString()),
//             if (schedule.subjectCreatedAt != null)
//               _buildInfoRow(
//                 'Создан',
//                 _formatDateTime(schedule.subjectCreatedAt!),
//               ),
//           ]),

//           const SizedBox(height: 16),

//           _buildInfoCard('Группа', [
//             _buildInfoRow('ID', schedule.groupId.toString()),
//             _buildInfoRow('Название', schedule.groupName),
//             _buildInfoRow('Организация', schedule.groupOrg.toString()),
//             if (schedule.groupCreatedAt != null)
//               _buildInfoRow(
//                 'Создана',
//                 _formatDateTime(schedule.groupCreatedAt!),
//               ),
//           ]),

//           const SizedBox(height: 16),

//           _buildInfoCard('Аудитория', [
//             _buildInfoRow('ID', schedule.classroomId.toString()),
//             _buildInfoRow('Название', schedule.classroomTitle),
//             if (schedule.classroomFloor != null)
//               _buildInfoRow('Этаж', schedule.classroomFloor.toString()),
//             if (schedule.classroomBuilding != null)
//               _buildInfoRow('Здание', schedule.classroomBuilding!),
//             _buildInfoRow('Организация', schedule.classroomOrg.toString()),
//             if (schedule.classroomCreatedAt != null)
//               _buildInfoRow(
//                 'Создана',
//                 _formatDateTime(schedule.classroomCreatedAt!),
//               ),
//           ]),

//           const SizedBox(height: 16),

//           _buildInfoCard('Статус и системная информация', [
//             _buildInfoRow(
//               'Отменено',
//               schedule.isCanceled ? 'Да' : 'Нет',
//               valueColor: schedule.isCanceled ? Colors.red : Colors.green,
//             ),
//             _buildInfoRow(
//               'Завершено',
//               schedule.isCompleted ? 'Да' : 'Нет',
//               valueColor: schedule.isCompleted ? Colors.green : Colors.grey,
//             ),
//             _buildInfoRow('Организация', schedule.org.toString()),
//             if (schedule.createdBy != null)
//               _buildInfoRow('Создатель (ID)', schedule.createdBy.toString()),
//             if (schedule.periodSchedule != null)
//               _buildInfoRow(
//                 'Периодическое расписание (ID)',
//                 schedule.periodSchedule.toString(),
//               ),
//             _buildInfoRow('Создано', schedule.formattedCreatedAt),
//           ]),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, List<Widget> children) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 12),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 200,
//             child: Text(
//               '$label:',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: valueColor,
//                 fontWeight: valueColor != null ? FontWeight.w500 : null,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDateTime(String dateTime) {
//     try {
//       final dt = DateTime.parse(dateTime);
//       return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
//     } catch (e) {
//       return dateTime;
//     }
//   }

//   String _formatDate(String date) {
//     try {
//       final dt = DateTime.parse(date);
//       return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}';
//     } catch (e) {
//       return date;
//     }
//   }

//   String _formatTime(String time) {
//     if (time.length >= 5) {
//       return time.substring(0, 5);
//     }
//     return time;
//   }
// }
