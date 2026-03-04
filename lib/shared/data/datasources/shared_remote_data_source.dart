import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/core/storage/secure_storage_repository.dart';
import 'package:treemov/shared/data/models/accrual_response_model.dart';
import 'package:treemov/shared/data/models/classroom_response_model.dart';
import 'package:treemov/shared/data/models/lesson_response_model.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_member_response_model.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';
import 'package:treemov/shared/data/models/student_response_model.dart';
import 'package:treemov/shared/data/models/subject_response_model.dart';
import 'package:treemov/shared/data/models/teacher_response_model.dart';

class SharedRemoteDataSource {
  final DioClient _dioClient;
  final SecureStorageRepository _secureStorageRepository;

  SharedRemoteDataSource(this._dioClient, this._secureStorageRepository);

  Future<OrgMemberResponseModel> getMyOrgMember() async {
    try {
      final orgMemberId = await _secureStorageRepository.getOrgMemberId();
      final Response response = await _dioClient.get(ApiConstants.myOrgs);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          final orgMember = responseData.firstWhere(
            (member) => member['id'].toString() == orgMemberId,
            orElse: () => null,
          );

          if (orgMember != null) {
            return OrgMemberResponseModel.fromJson(orgMember);
          } else {
            throw Exception('Организация с id $orgMemberId не найдена');
          }
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки моего профиля: $e');
    }
  }

  Future<List<LessonResponseModel>> getLessons({
    String? dateMin,
    String? dateMax,
  }) async {
    try {
      final queryParams = <String, dynamic>{};

      if (dateMin != null) {
        queryParams['date_min'] = dateMin;
      }
      if (dateMax != null) {
        queryParams['date_max'] = dateMax;
      }

      final Response response = await _dioClient.get(
        ApiConstants.lessons,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          return responseData
              .map<LessonResponseModel>(
                (json) => LessonResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
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

  Future<int?> getTeacherId() async {
    try {
      final orgMemberID = await _secureStorageRepository.getOrgMemberId();

      final Response response = await _dioClient.get(
        ApiConstants.teachers,
        queryParameters: {'employee__org_member_id': orgMemberID},
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
      final Response response = await _dioClient.get(ApiConstants.subjects);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          return responseData
              .map<SubjectResponseModel>(
                (json) => SubjectResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
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
          return responseData
              .map<GroupStudentsResponseModel>(
                (json) => GroupStudentsResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
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
        ApiConstants.studentGroupMembers,
        queryParameters: {'student_group__id': groupId},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          return responseData
              .map<StudentInGroupResponseModel>(
                (json) => StudentInGroupResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
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
          return responseData
              .map<ClassroomResponseModel>(
                (json) => ClassroomResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
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

  Future<StudentResponseModel> getStudentProfile() async {
    try {
      final orgMemberId = await _secureStorageRepository.getOrgMemberId();

      final queryParams = <String, dynamic>{};

      if (orgMemberId != null) {
        queryParams['org_member'] = orgMemberId;
      }

      final Response response = await _dioClient.get(
        ApiConstants.students,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List && responseData.isNotEmpty) {
          if (orgMemberId != null) {
            final student = responseData.firstWhere(
              (s) =>
                  s['org_member']?['id'].toString() == orgMemberId.toString(),
              orElse: () => null,
            );
            if (student != null) {
              return StudentResponseModel.fromJson(student);
            }
          }
          return StudentResponseModel.fromJson(responseData.first);
        } else if (responseData is Map<String, dynamic>) {
          return StudentResponseModel.fromJson(responseData);
        } else {
          throw Exception('Ученик не найден');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки профиля ученика: $e');
    }
  }

  Future<List<AccrualResponseModel>> getStudentAccruals({
    required int? studentId,
    required int page,
  }) async {
    try {
      if (studentId == null) {
        throw Exception('ID ученика не указан');
      }

      final Response response = await _dioClient.get(
        ApiConstants.accruals,
        queryParameters: {'student': studentId, 'page': page, 'page_size': 20},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData['results'] != null) {
          return (responseData['results'] as List)
              .map<AccrualResponseModel>(
                (json) => AccrualResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is List) {
          return responseData
              .map<AccrualResponseModel>(
                (json) => AccrualResponseModel.fromJson(json),
              )
              .toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки начислений ученика: $e');
    }
  }
}
