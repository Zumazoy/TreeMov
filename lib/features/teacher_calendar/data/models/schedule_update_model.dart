// import 'package:flutter/material.dart';
// import 'package:treemov/features/teacher_calendar/data/models/schedule_request_model.dart';
// import 'package:treemov/features/teacher_calendar/data/models/schedule_response_model.dart';

// class ScheduleUpdateModel {
//   final int? classroomId;
//   final int? groupId;
//   final int? periodScheduleId;
//   final int? teacherId;
//   final int? subjectId;
//   final int? lesson;
//   final String? title;
//   final DateTime? date;
//   final TimeOfDay? startTime;
//   final TimeOfDay? endTime;
//   final bool? isCanceled;
//   final bool? isCompleted;

//   // Добавляем исходное расписание для сравнения
//   final ScheduleResponseModel? originalSchedule;

//   ScheduleUpdateModel({
//     this.classroomId,
//     this.groupId,
//     this.periodScheduleId,
//     this.teacherId,
//     this.subjectId,
//     this.lesson,
//     this.title,
//     this.date,
//     this.startTime,
//     this.endTime,
//     this.isCanceled,
//     this.isCompleted,
//     this.originalSchedule,
//   });

//   // Конвертация в JSON (только измененные поля)
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};

//     if (_isFieldChanged('classroom', classroomId)) {
//       data['classroom'] = classroomId;
//     }
//     if (_isFieldChanged('group', groupId)) {
//       data['group'] = groupId;
//     }
//     if (_isFieldChanged('period_schedule', periodScheduleId)) {
//       data['period_schedule'] = periodScheduleId;
//     }
//     if (_isFieldChanged('teacher', teacherId)) {
//       data['teacher'] = teacherId;
//     }
//     if (_isFieldChanged('subject', subjectId)) {
//       data['subject'] = subjectId;
//     }
//     if (_isFieldChanged('lesson', lesson)) {
//       data['lesson'] = lesson;
//     }
//     if (_isFieldChanged('title', title)) {
//       data['title'] = title;
//     }
//     if (_isFieldChanged('date', date)) {
//       data['date'] = _formatDate(date!);
//     }
//     if (_isFieldChanged('start_time', startTime)) {
//       data['start_time'] = _formatTime(startTime!);
//     }
//     if (_isFieldChanged('end_time', endTime)) {
//       data['end_time'] = _formatTime(endTime!);
//     }
//     if (_isFieldChanged('is_canceled', isCanceled)) {
//       data['is_canceled'] = isCanceled;
//     }
//     if (_isFieldChanged('is_completed', isCompleted)) {
//       data['is_completed'] = isCompleted;
//     }

//     return data;
//   }

//   bool _isFieldChanged(String fieldName, dynamic newValue) {
//     if (originalSchedule == null) {
//       // Если нет исходного расписания, отправляем все поля
//       return newValue != null;
//     }

//     switch (fieldName) {
//       case 'classroom':
//         return newValue != null && newValue != originalSchedule!.classroom?.id;
//       case 'group':
//         return newValue != null && newValue != originalSchedule!.group?.id;
//       case 'period_schedule':
//         return newValue != originalSchedule!.periodSchedule;
//       case 'teacher':
//         return newValue != null && newValue != originalSchedule!.teacher?.id;
//       case 'subject':
//         return newValue != null && newValue != originalSchedule!.subject?.id;
//       case 'lesson':
//         return newValue != originalSchedule!.lesson;
//       case 'title':
//         return newValue != null && newValue != originalSchedule!.title;
//       case 'date':
//         if (newValue == null) return false;
//         final originalDate = originalSchedule!.date;
//         final formattedNewDate = _formatDate(newValue);
//         return formattedNewDate != originalDate;
//       case 'start_time':
//         if (newValue == null) return false;
//         final originalStartTime = originalSchedule!.startTime;
//         if (originalStartTime == null) return true;
//         final formattedNewTime = _formatTime(newValue);
//         return formattedNewTime != originalStartTime;
//       case 'end_time':
//         if (newValue == null) return false;
//         final originalEndTime = originalSchedule!.endTime;
//         if (originalEndTime == null) return true;
//         final formattedNewTime = _formatTime(newValue);
//         return formattedNewTime != originalEndTime;
//       case 'is_canceled':
//         return newValue != null && newValue != originalSchedule!.isCanceled;
//       case 'is_completed':
//         return newValue != null && newValue != originalSchedule!.isCompleted;
//       default:
//         return newValue != null;
//     }
//   }

//   String _formatDate(DateTime date) {
//     return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
//   }

//   String _formatTime(TimeOfDay time) {
//     return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
//   }

//   // Создание из существующего ScheduleRequestModel
//   factory ScheduleUpdateModel.fromRequestModel(ScheduleRequestModel request) {
//     return ScheduleUpdateModel(
//       classroomId: request.classroomId,
//       groupId: request.groupId,
//       periodScheduleId: request.periodScheduleId,
//       teacherId: request.teacherId,
//       subjectId: request.subjectId,
//       lesson: request.lesson,
//       title: request.title,
//       date: request.date,
//       startTime: request.startTime,
//       endTime: request.endTime,
//       isCanceled: request.isCanceled,
//       isCompleted: request.isCompleted,
//     );
//   }

//   // Создание с исходным расписанием для сравнения
//   factory ScheduleUpdateModel.withOriginal({
//     required ScheduleResponseModel original,
//     int? classroomId,
//     int? groupId,
//     int? periodScheduleId,
//     int? teacherId,
//     int? subjectId,
//     int? lesson,
//     String? title,
//     DateTime? date,
//     TimeOfDay? startTime,
//     TimeOfDay? endTime,
//     bool? isCanceled,
//     bool? isCompleted,
//   }) {
//     return ScheduleUpdateModel(
//       originalSchedule: original,
//       classroomId: classroomId,
//       groupId: groupId,
//       periodScheduleId: periodScheduleId,
//       teacherId: teacherId,
//       subjectId: subjectId,
//       lesson: lesson,
//       title: title,
//       date: date,
//       startTime: startTime,
//       endTime: endTime,
//       isCanceled: isCanceled,
//       isCompleted: isCompleted,
//     );
//   }
// }
