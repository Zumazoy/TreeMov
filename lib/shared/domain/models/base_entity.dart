// Базовые данные для всех сущностей
class BaseEntityData {
  final int? id;

  const BaseEntityData({required this.id});
}

// Базовый класс для всех сущностей
abstract class BaseEntity {
  final BaseEntityData baseData;

  const BaseEntity({required this.baseData});

  int? get id => baseData.id;
}
