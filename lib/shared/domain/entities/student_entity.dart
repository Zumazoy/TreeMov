import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentEntity extends BaseResponseModel {
  final String? name;
  final String? surname;
  final String? progress;
  final String? phoneNumber;
  final String? birthday;
  final String? email;
  final String? avatar;
  final int? score;

  StudentEntity({
    required super.baseData,
    required this.name,
    required this.surname,
    required this.progress,
    required this.phoneNumber,
    required this.birthday,
    required this.email,
    required this.avatar,
    required this.score,
  });

  factory StudentEntity.fromJson(Map<String, dynamic> json) {
    return StudentEntity(
      baseData: json.baseData,
      name: json['name'],
      surname: json['surname'],
      progress: json['progress'],
      phoneNumber: json['phone_number'],
      birthday: json['birthday'],
      email: json['email'],
      avatar: json['avatar'],
      score: json['score'],
    );
  }
}
