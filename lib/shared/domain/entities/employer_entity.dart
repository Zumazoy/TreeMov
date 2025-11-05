class EmployerEntity {
  final int employerId;
  final String employerName;
  final String employerSurname;
  final String? employerPatronymic;
  final String? employerBirthday;
  final String? employerEmail;
  final String? employerPassportSeries;
  final String? employerPassportNum;
  final String? employerInn;
  final String? employerCreatedAt;
  final int employerOrg;
  final int? employerCreatedBy;
  final int? employerDepartment;

  EmployerEntity({
    required this.employerId,
    required this.employerName,
    required this.employerSurname,
    required this.employerPatronymic,
    required this.employerBirthday,
    required this.employerEmail,
    required this.employerPassportSeries,
    required this.employerPassportNum,
    required this.employerInn,
    required this.employerCreatedAt,
    required this.employerOrg,
    required this.employerCreatedBy,
    required this.employerDepartment,
  });

  factory EmployerEntity.fromJson(Map<String, dynamic> json) {
    return EmployerEntity(
      employerId: json['id'] ?? 0,
      employerName: json['name'] ?? 0,
      employerSurname: json['surname'] ?? 0,
      employerPatronymic: json['patronymic'] ?? 0,
      employerBirthday: json['birthday'] ?? 0,
      employerEmail: json['email'] ?? 0,
      employerPassportSeries: json['passport_series'] ?? 0,
      employerPassportNum: json['passport_num'] ?? 0,
      employerInn: json['inn'] ?? 0,
      employerCreatedAt: json['created_at'] ?? 0,
      employerOrg: json['org'] ?? 0,
      employerCreatedBy: json['created_by'] ?? 0,
      employerDepartment: json['department'] ?? 0,
    );
  }
}
