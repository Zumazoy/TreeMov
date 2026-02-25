import 'package:dio/dio.dart';
import 'package:treemov/core/constants/api_constants.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/features/organizations/data/models/invite_response_model.dart';
import 'package:treemov/shared/data/models/org_member_response_model.dart';

class OrgsRemoteDataSource {
  final DioClient _dioClient;

  OrgsRemoteDataSource(this._dioClient);

  Future<List<OrgMemberResponseModel>> getMyOrgs() async {
    try {
      final Response response = await _dioClient.get(ApiConstants.myOrgs);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив
          return responseData
              .map<OrgMemberResponseModel>(
                (json) => OrgMemberResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - не массив (оборачиваем в список)
          return [OrgMemberResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки организаций: $e');
    }
  }

  Future<List<InviteResponseModel>> getMyInvites() async {
    try {
      final Response response = await _dioClient.get(
        ApiConstants.myInvites,
        queryParameters: {'status': 'sending'},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Если ответ - массив
          return responseData
              .map<InviteResponseModel>(
                (json) => InviteResponseModel.fromJson(json),
              )
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // Если ответ - не массив (оборачиваем в список)
          return [InviteResponseModel.fromJson(responseData)];
        } else {
          throw Exception('Некорректный формат ответа от сервера');
        }
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка загрузки приглашений: $e');
    }
  }

  Future<bool> acceptInvite(String uuid) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.acceptInvite,
        queryParameters: {'uuid': uuid},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Неверный код ответа: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка принятия приглашения: $e');
    }
  }
}
