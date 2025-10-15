import 'dart:ffi';

class GetStudentsResponse {
  final Long id;
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

  GetStudentsResponse({
    required this.id,
    this.groups,
    required this.name,
    required this.surname,
    this.progress,
    this.phoneNumber,
    required this.birthday,
    this.email,
    this.avatar,
    this.org,
    this.createdBy,
  });

  factory GetStudentsResponse.fromJson(Map<String, dynamic> json) {
    return GetStudentsResponse(
      id: json['id'],
      groups: json['groups'],
      name: json['name'],
      surname: json['surname'],
      progress: json['progress'],
      phoneNumber: json['phone_number'],
      birthday: json['birthday'],
      email: json['email'],
      avatar: json['avatar'],
      org: json['org'],
      createdBy: json['created_by'],
    );
  }
}
