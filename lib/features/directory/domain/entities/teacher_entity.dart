class TeacherEntity {
  final String id;
  final String fullName;
  final String? avatarUrl;

  const TeacherEntity({
    required this.id,
    required this.fullName,
    this.avatarUrl,
  });
}
