import 'package:treemov/shared/domain/entities/color_entity.dart';
import 'package:treemov/shared/domain/models/base_entity.dart';

class SubjectResponseModel extends BaseEntity {
  final String? name;
  final ColorEntity? color;
  final List<dynamic> teacher;

  SubjectResponseModel({
    required super.baseData,
    required this.name,
    required this.color,
    required this.teacher,
  });
}
