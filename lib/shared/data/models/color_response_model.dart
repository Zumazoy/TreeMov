import 'package:treemov/shared/domain/models/base_response_model.dart';

class ColorResponseModel extends BaseResponseModel {
  final String? title;
  final String? hex;

  ColorResponseModel({
    required super.baseData,
    required this.title,
    required this.hex,
  });

  factory ColorResponseModel.fromJson(Map<String, dynamic> json) {
    return ColorResponseModel(
      baseData: json.baseData,
      title: json['title'],
      hex: json['color_hex'],
    );
  }
}
