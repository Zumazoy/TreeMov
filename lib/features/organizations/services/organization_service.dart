import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../models/organization.dart';

class OrganizationService {
  final DioClient _dioClient;

  OrganizationService(this._dioClient);

  Future<OrganizationMember> createOrganization(String title) async {
    try {
      final request = OrganizationCreateRequest(title: title);
      final Response response = await _dioClient.post(
        '/organizations/init',
        data: request.toJson(),
      );
      
      return OrganizationMember.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<OrganizationMember>> getMyOrganizations() async {
    try {
      final Response response = await _dioClient.get('/organizations/me');
      
      final List<dynamic> data = response.data;
      return data.map((json) => OrganizationMember.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<OrganizationMember>> getOrganizationMembers(int organizationId) async {
    try {

      final Response response = await _dioClient.get(
        '/organizations/members',
        queryParameters: {'organization_id': organizationId},
      );
      
      final List<dynamic> data = response.data;
      return data.map((json) => OrganizationMember.fromJson(json)).toList();
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