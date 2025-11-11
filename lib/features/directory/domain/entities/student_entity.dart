import 'parent_contact_entity.dart';

class StudentEntity {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final String currentGroupId;
  final String email;
  final DateTime groupJoinDate;
  final DateTime birthDate;
  final String phone;
  final List<String> otherGroupIds;
  final String classTeacherId;
  final List<ParentContactEntity> parentContacts;

  const StudentEntity({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    required this.currentGroupId,
    required this.email,
    required this.groupJoinDate,
    required this.birthDate,
    required this.phone,
    required this.otherGroupIds,
    required this.classTeacherId,
    required this.parentContacts,
  });

  int get age {
    return DateTime.now().difference(birthDate).inDays ~/ 365;
  }

  String get formattedBirthDate {
    return '${birthDate.day}.${birthDate.month}.${birthDate.year}';
  }

  String get formattedGroupJoinDate {
    return '${groupJoinDate.day}.${groupJoinDate.month}.${groupJoinDate.year}';
  }
}
