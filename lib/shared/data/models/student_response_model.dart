import 'package:treemov/shared/domain/entities/student_entity.dart';
import 'package:treemov/shared/domain/models/base_response_model.dart';

class StudentResponseModel extends BaseResponseModel
    with EntityConvertible<StudentEntity> {
  final String? name;
  final String? surname;
  final String? progress;
  final String? phoneNumber;
  final String? birthday;
  final String? email;
  final String? avatar;
  final int? score;

  StudentResponseModel({
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

  factory StudentResponseModel.fromJson(Map<String, dynamic> json) {
    return StudentResponseModel(
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

  @override
  StudentEntity toEntity() {
    return StudentEntity(
      baseData: baseData.toEntityData(),
      name: name,
      surname: surname,
      progress: progress,
      phoneNumber: phoneNumber,
      birthday: birthday,
      email: email,
      avatar: avatar,
      score: score,
    );
  }
}
