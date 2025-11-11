class EmployerEntity {
  final int id;
  final String? name;
  final String? surname;
  final String? patronymic;
  final String? birthday;
  final String? email;
  final String? passportSeries;
  final String? passportNum;
  final String? inn;
  final String? createdAt;
  final int? org;
  final int? createdBy;
  final int? department;

  EmployerEntity({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.birthday,
    required this.email,
    required this.passportSeries,
    required this.passportNum,
    required this.inn,
    required this.createdAt,
    required this.org,
    required this.createdBy,
    required this.department,
  });

  factory EmployerEntity.fromJson(Map<String, dynamic> json) {
    return EmployerEntity(
      id: json['id'] ?? 0,
      name: json['name'],
      surname: json['surname'],
      patronymic: json['patronymic'],
      birthday: json['birthday'],
      email: json['email'],
      passportSeries: json['passport_series'],
      passportNum: json['passport_num'],
      inn: json['inn'],
      createdAt: json['created_at'],
      org: json['org'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      department: json['department'] ?? 0,
    );
  }
}
