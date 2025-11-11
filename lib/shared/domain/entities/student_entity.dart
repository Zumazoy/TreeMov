class StudentEntity {
  final int id;
  final String? name;
  final String? surname;
  final String? progress;
  final String? phoneNumber;
  final String? birthday;
  final String? email;
  final String? avatar;
  final String? createdAt;
  final int? score;
  final int? org;
  final int? createdBy;

  StudentEntity({
    required this.id,
    required this.name,
    required this.surname,
    required this.progress,
    required this.phoneNumber,
    required this.birthday,
    required this.email,
    required this.avatar,
    required this.createdAt,
    required this.score,
    required this.org,
    required this.createdBy,
  });

  factory StudentEntity.fromJson(Map<String, dynamic> json) {
    return StudentEntity(
      id: json['id'] ?? 0,
      name: json['name'],
      surname: json['surname'],
      progress: json['progress'],
      phoneNumber: json['phone_number'],
      birthday: json['birthday'],
      email: json['email'],
      avatar: json['avatar'],
      createdAt: json['created_at'],
      score: json['score'] ?? 0,
      org: json['org'] ?? 0,
      createdBy: json['created_by'] ?? 0,
    );
  }
}
