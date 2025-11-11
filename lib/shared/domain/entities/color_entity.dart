class ColorEntity {
  final int id;
  final String? title;
  final String? hex;
  final int? org;
  final String? createdAt;
  final int? createdBy;

  ColorEntity({
    required this.id,
    required this.title,
    required this.hex,
    required this.org,
    required this.createdAt,
    required this.createdBy,
  });

  factory ColorEntity.fromJson(Map<String, dynamic> json) {
    return ColorEntity(
      id: json['id'] ?? 0,
      title: json['title'],
      hex: json['color_hex'],
      org: json['org'] ?? 0,
      createdAt: json['created_at'],
      createdBy: json['created_by'] ?? 0,
    );
  }
}
