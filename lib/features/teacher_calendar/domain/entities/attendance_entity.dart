import 'package:treemov/shared/data/models/student_response_model.dart';

class AttendanceEntity {
  final int index;
  final bool? originalWasPresent;
  final int? id;
  bool? wasPresent;
  final StudentResponseModel? student;

  AttendanceEntity({
    required this.index,
    required this.id,
    this.wasPresent,
    required this.student,
  }) : originalWasPresent = wasPresent;

  bool isChanged() => wasPresent != originalWasPresent;

  bool shouldCreate() => originalWasPresent == null;

  String get name {
    if (student != null) {
      final parts = [
        student!.surname,
        student!.name,
      ].where((part) => part != null && part.isNotEmpty).toList();

      return parts.isNotEmpty ? parts.join(' ') : 'Неизвестный студент';
    }
    return 'Дефолт';
  }
}
