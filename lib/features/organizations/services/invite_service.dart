import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../models/invite.dart';

class InviteService {
  final DioClient _dioClient;

  InviteService(this._dioClient);

  Future<List<Invite>> getInvites() async {
    try {
      final Response response = await _dioClient.get('/invites');
      
      final List<dynamic> data = response.data;
      return data.map((json) => Invite.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Invite> createInvite(int roleId, String email) async {
    try {
      final request = InviteCreateRequest(roleId: roleId, email: email);
      final Response response = await _dioClient.post(
        '/invites',
        data: request.toJson(),
      );
      
      return Invite.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> acceptInvite(String uuid) async {
    try {
      await _dioClient.post('/invites/accept?uuid=$uuid');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> acceptInviteWithParams(String uuid) async {
    try {
      await _dioClient.get('/invites/accept', queryParameters: {'uuid': uuid});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      final message = data['message'] ?? data['detail'] ?? 'Произошла ошибка';
      return Exception(message);
    }
    return Exception('Сетевая ошибка');
  }
}