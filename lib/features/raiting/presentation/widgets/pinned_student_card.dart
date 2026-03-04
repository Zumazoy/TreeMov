import 'package:flutter/material.dart';
import 'package:treemov/features/raiting/presentation/widgets/student_card.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

class PinnedStudentCard extends StatelessWidget {
  final StudentEntity student;
  final int position;

  const PinnedStudentCard({
    super.key,
    required this.student,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: StudentCard(
          student: student,
          position: position,
          isCurrentUser: true,
        ),
      ),
    );
  }
}
