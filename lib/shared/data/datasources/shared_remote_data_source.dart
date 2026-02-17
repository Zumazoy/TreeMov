import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/student_in_group_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
// import 'package:treemov/shared/data/models/teacher_response_model.dart';
import 'package:treemov/shared/storage/domain/repositories/secure_storage_repository.dart';

class SharedRemoteDataSource {
  final DioClient _dioClient;
  final SecureStorageRepository _secureStorageRepository;

  SharedRemoteDataSource(this._dioClient, this._secureStorageRepository);

  Future<OrgMemberResponseModel> getMyOrgProfile() async {
    try {
      final orgId = await _secureStorageRepository.getOrgId();
      final Response response = await _dioClient.get(ApiConstants.myOrgs);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          final orgMember = responseData.firstWhere(
            (member) => member['org']['id'].toString() == orgId,
            orElse: () => null,
          );

          if (orgMember != null) {
            debugPrint('$orgMember');
            return OrgMemberResponseModel.fromJson(orgMember);
          } else {
            throw Exception('Организация с id $orgId не найдена');
          }
        } else {
          throw Exception(
            'Некорректный формат ответа от сервера:\n$responseData',
          );
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки моего профиля: $e');
    }
  }

  Future<List<LessonResponseModel>> getLessons() async {
    try {
      final Response response = await _dioClient.get(ApiConstants.lessons);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив
          return responseData
              .map<LessonResponseModel>(
                (json) => LessonResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - не массив (оборачиваем в список)
          return [LessonResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки расписания: $e');
    }
  }

  // Future<int?> getTeacherId() async {
  //   try {
  //     final Response response = await _dioClient.get(ApiConstants.teachers);

  //     if (response.statusCode == 200) {
  //       final responseData = response.data;

  //       if (responseData is List && responseData.isNotEmpty) {
  //         return TeacherResponseModel.fromJson(responseData.first).id;
  //       } else if (responseData is Map<String, dynamic>) {
  //         return TeacherResponseModel.fromJson(responseData).id;
  //       } else {
  //         return null;
  //       }
  //     } else {
  //       throw Exception('Ошибка сервера: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Ошибка загрузки ID учителя: $e');
  //   }
  // }

  Future<List<SubjectResponseModel>> getSubjects() async {
    try {
      final Response response = await _dioClient.get(ApiConstants.subjects);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив
          return responseData
              .map<SubjectResponseModel>(
                (json) => SubjectResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - не массив (оборачиваем в список)
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

  Future<List<GroupStudentsResponseModel>> getGroupStudents() async {
    try {
      final Response response = await _dioClient.get(
        ApiConstants.studentGroups,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив
          return responseData
              .map<GroupStudentsResponseModel>(
                (json) => GroupStudentsResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - не массив (оборачиваем в список)
          return [GroupStudentsResponseModel.fromJson(responseData)];
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

  Future<List<StudentInGroupResponseModel>> getStudentsInGroup(
    int groupId,
  ) async {
    try {
      final Response response = await _dioClient.get(
        '${ApiConstants.studentGroups}$groupId/${ApiConstants.students}',
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив
          return responseData
              .map<StudentInGroupResponseModel>(
                (json) => StudentInGroupResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - не массив (оборачиваем в список)
          return [StudentInGroupResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки студентов в группе: $e');
    }
  }

  Future<List<ClassroomResponseModel>> getClassrooms() async {
    try {
      final Response response = await _dioClient.get(ApiConstants.classrooms);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив
          return responseData
              .map<ClassroomResponseModel>(
                (json) => ClassroomResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - не массив (оборачиваем в список)
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
}
