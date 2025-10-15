import 'dart:ffi';

class StudentEntity {
  final BigInt id;
  final List<int>? groups;
  final String name;
  final String surname;
  final double? progress;
  final int? phoneNumber;
  final DateTime birthday;
  final String? email;
  final String? avatar;
  final Long? org;
  final Long? createdBy;

  StudentEntity({
    required this.id,
    required this.groups,
    required this.name,
    required this.surname,
    required this.progress,
    required this.phoneNumber,
    required this.birthday,
    required this.email,
    required this.avatar,
    required this.org,
    required this.createdBy,
  });
}
