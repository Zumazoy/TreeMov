import 'package:treemov/shared/domain/models/base_entity.dart';

class ColorEntity extends BaseEntity {
  final String? title;
  final String? hex;

  ColorEntity({
    required super.baseData,
    required this.title,
    required this.hex,
  });
}
