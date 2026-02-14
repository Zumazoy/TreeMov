import 'package:treemov/shared/domain/models/base_response_model.dart';

class ProfileResponseModel extends BaseResponseModel {
  final int? userId;
  final String? email;
  final String? name;
  final String? surname;
  final String? patronymic;

  ProfileResponseModel({
    required super.baseData,
    required this.userId,
    required this.email,
    required this.name,
    required this.surname,
    required this.patronymic,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      baseData: json.baseData,
      userId: json['user_id'],
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      patronymic: json['pathronamic'],
    );
  }
}
