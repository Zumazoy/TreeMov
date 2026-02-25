import 'package:treemov/shared/domain/models/base_entity.dart';

// Базовые данные для всех response моделей
class BaseResponseData {
  final int? id;
  final dynamic detail;

  const BaseResponseData({required this.id, required this.detail});

  factory BaseResponseData.fromJson(Map<String, dynamic> json) {
    return BaseResponseData(id: json['id'] ?? 0, detail: json['detail']);
  }

  BaseEntityData toEntityData() {
    return BaseEntityData(id: id);
  }
}

// Базовый класс для всех response моделей
abstract class BaseResponseModel {
  final BaseResponseData baseData;

  const BaseResponseModel({required this.baseData});

  int? get id => baseData.id;
  dynamic get detail => baseData.detail;
}

extension BaseResponseParsing on Map<String, dynamic> {
  BaseResponseData get baseData => BaseResponseData.fromJson(this);
}

mixin EntityConvertible<T extends BaseEntity> on BaseResponseModel {
  T toEntity();
}
