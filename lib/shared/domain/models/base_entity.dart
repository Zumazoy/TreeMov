// Базовые данные для всех сущностей
class BaseEntityData {
  final int? id;
  final int? org;
  final int? createdBy;
  final String? createdAt;

  const BaseEntityData({
    required this.id,
    required this.org,
    required this.createdBy,
    required this.createdAt,
  });
}

// Базовый класс для всех сущностей
abstract class BaseEntity {
  final BaseEntityData baseData;

  const BaseEntity({required this.baseData});

  int? get id => baseData.id;
  int? get org => baseData.org;
  int? get createdBy => baseData.createdBy;
  String? get createdAt => baseData.createdAt;
}
