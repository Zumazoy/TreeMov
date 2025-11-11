import 'package:treemov/shared/domain/models/base_response_model.dart';

class ColorEntity extends BaseResponseModel {
  final String? title;
  final String? hex;

  ColorEntity({
    required super.baseData,
    required this.title,
    required this.hex,
  });

  factory ColorEntity.fromJson(Map<String, dynamic> json) {
    return ColorEntity(
      baseData: json.baseData,
      title: json['title'],
      hex: json['color_hex'],
    );
  }
}
