class ClassroomResponseModel {
  final int id;
  final int? org;
  final int? createdBy;
  final String? createdAt;
  final String? title;
  final String? building;
  final int? floor;

  ClassroomResponseModel({
    required this.id,
    required this.org,
    required this.createdBy,
    required this.createdAt,
    required this.title,
    required this.building,
    required this.floor,
  });

  factory ClassroomResponseModel.fromJson(Map<String, dynamic> json) {
    return ClassroomResponseModel(
      id: json['id'] ?? 0,
      org: json['org'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'],
      title: json['title'],
      building: json['building'],
      floor: json['floor'] ?? 0,
    );
  }
}
