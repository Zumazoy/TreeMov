import 'package:treemov/shared/data/models/org_member_response_model.dart';
import 'package:treemov/shared/domain/models/base_entity.dart';

class StudentEntity extends BaseEntity {
  final int id;
  final String? name;
  final String? surname;
  final String? patronymic;
  final String? progress;
  final String? birthday;
  final int score;
  final OrgMemberResponseModel? orgMember;

  // Вычисляемые поля для UI
  String get fullName {
    final parts = [
      surname,
      name,
      patronymic,
    ].where((part) => part != null && part.isNotEmpty).join(' ');
    return parts.isNotEmpty ? parts : 'Без имени';
  }

  String get initials {
    final first = name?.isNotEmpty == true ? name![0].toUpperCase() : '';
    final last = surname?.isNotEmpty == true ? surname![0].toUpperCase() : '';

    if (first.isEmpty && last.isEmpty) return '??';
    if (first.isEmpty) return '$last$last';
    if (last.isEmpty) return '$first$first';
    return '$first$last';
  }

  StudentEntity({
    required super.baseData,
    required this.id,
    this.name,
    this.surname,
    this.patronymic,
    this.progress,
    this.birthday,
    this.score = 0,
    this.orgMember,
  });
}
