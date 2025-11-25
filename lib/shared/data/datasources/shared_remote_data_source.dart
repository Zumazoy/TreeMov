import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/teacher_calendar/data/models/period_schedule_response_model.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';

class SharedRemoteDataSource {
  final DioClient _dioClient;

  SharedRemoteDataSource(this._dioClient);

  Future<int?> getTeacherId() async {
    try {
      final Response response = await _dioClient.get(
        ApiConstants.employersP + ApiConstants.teachers,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List && responseData.isNotEmpty) {
          return TeacherResponseModel.fromJson(responseData.first).id;
        } else if (responseData is Map<String, dynamic>) {
          return TeacherResponseModel.fromJson(responseData).id;
        } else {
          return null;
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки ID учителя: $e');
    }
  }

  Future<List<SubjectResponseModel>> getSubjects() async {
    try {
      final Response response = await _dioClient.get(
        ApiConstants.scheduleP + ApiConstants.subjects,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив занятий
          return responseData
              .map<SubjectResponseModel>(
                (json) => SubjectResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - одиночное занятие (оборачиваем в список)
          return [SubjectResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки предметов: $e');
    }
  }

  Future<List<StudentGroupResponseModel>> getStudentGroups() async {
    try {
      final Response response = await _dioClient.get(
        ApiConstants.studentsP + ApiConstants.studentGroups,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив занятий
          return responseData
              .map<StudentGroupResponseModel>(
                (json) => StudentGroupResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - одиночное занятие (оборачиваем в список)
          return [StudentGroupResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки групп студентов: $e');
    }
  }

  Future<StudentGroupResponseModel> getStudentGroupById(int groupId) async {
    try {
      final Response response = await _dioClient.get(
        '${ApiConstants.studentsP + ApiConstants.studentGroups}$groupId/',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        return StudentGroupResponseModel.fromJson(responseData);
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки группы: $e');
    }
  }

  Future<List<ClassroomResponseModel>> getClassrooms() async {
    try {
      final Response response = await _dioClient.get(
        ApiConstants.scheduleP + ApiConstants.classrooms,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив занятий
          return responseData
              .map<ClassroomResponseModel>(
                (json) => ClassroomResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - одиночное занятие (оборачиваем в список)
          return [ClassroomResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки аудиторий: $e');
    }
  }

  Future<List<PeriodScheduleResponseModel>> getPeriodSchedules() async {
    try {
      final Response response = await _dioClient.get(
        ApiConstants.scheduleP + ApiConstants.periodLessons,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив занятий
          return responseData
              .map<PeriodScheduleResponseModel>(
                (json) => PeriodScheduleResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - одиночное занятие (оборачиваем в список)
          return [PeriodScheduleResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки периодических занятий: $e');
    }
  }
}
