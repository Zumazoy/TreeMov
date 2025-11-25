class TeacherEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String position;
  final String? avatarUrl;

  TeacherEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.position,
    this.avatarUrl,
  });

  String get fullName => '$lastName $firstName $middleName';
}
