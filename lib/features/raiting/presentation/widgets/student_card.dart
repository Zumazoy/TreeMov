import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

class StudentCard extends StatelessWidget {
  final StudentEntity student;
  final int position;
  final bool isCurrentUser;

  const StudentCard({
    super.key,
    required this.student,
    required this.position,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? AppColors.eventTap : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentUser
            ? Border.all(color: AppColors.achievementDeepBlue, width: 1.5)
            : null,
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          alignment: Alignment.center,
          child: Text(
            position.toString(),
            style: TextStyle(
              color: AppColors.achievementDeepBlue,
              fontSize: 16,
              fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.achievementDeepBlue,
              child: Text(
                student.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                student.fullName,
                style: TextStyle(
                  color: AppColors.achievementDeepBlue,
                  fontWeight: isCurrentUser
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              student.score.toString(),
              style: const TextStyle(
                color: AppColors.achievementDeepBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.bolt,
              color: AppColors.achievementDeepBlue,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
