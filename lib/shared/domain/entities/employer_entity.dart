import 'package:treemov/shared/domain/models/base_response_model.dart';

class EmployerEntity extends BaseResponseModel {
  final String? name;
  final String? surname;
  final String? patronymic;
  final String? birthday;
  final String? email;
  final String? passportSeries;
  final String? passportNum;
  final String? inn;
  final int? department;

  EmployerEntity({
    required super.baseData,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.birthday,
    required this.email,
    required this.passportSeries,
    required this.passportNum,
    required this.inn,
    required this.department,
  });

  factory EmployerEntity.fromJson(Map<String, dynamic> json) {
    return EmployerEntity(
      baseData: json.baseData,
      name: json['name'],
      surname: json['surname'],
      patronymic: json['patronymic'],
      birthday: json['birthday'],
      email: json['email'],
      passportSeries: json['passport_series'],
      passportNum: json['passport_num'],
      inn: json['inn'],
      department: json['department'],
    );
  }
}
