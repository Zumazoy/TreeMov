import 'package:treemov/shared/domain/models/base_entity.dart';

class StudentEntity extends BaseEntity {
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
}
