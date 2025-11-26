// Базовые данные для всех response моделей
import 'package:treemov/shared/domain/models/base_entity.dart';

class BaseResponseData {
  final int? id;
  final int? org;
  final int? createdBy;
  final String? createdAt;

  const BaseResponseData({
    required this.id,
    required this.org,
    required this.createdBy,
    required this.createdAt,
  });

  factory BaseResponseData.fromJson(Map<String, dynamic> json) {
    return BaseResponseData(
      id: json['id'] ?? 0,
      org: json['org'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'],
    );
  }

  BaseEntityData toEntityData() {
    return BaseEntityData(
      id: id,
      org: org,
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }
}

// Базовый класс для всех response моделей
abstract class BaseResponseModel {
  final BaseResponseData baseData;

  const BaseResponseModel({required this.baseData});

  int? get id => baseData.id;
  int? get org => baseData.org;
  int? get createdBy => baseData.createdBy;
  String? get createdAt => baseData.createdAt;
}

extension BaseResponseParsing on Map<String, dynamic> {
  BaseResponseData get baseData => BaseResponseData.fromJson(this);
}

mixin EntityConvertible<T extends BaseEntity> on BaseResponseModel {
  T toEntity();
}
