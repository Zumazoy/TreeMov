import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/shared/domain/entities/lesson_entity.dart';

import 'lesson_item.dart';

class LessonsPanel extends StatelessWidget {
  final List<LessonEntity> lessons;
  final VoidCallback onClose;

  const LessonsPanel({super.key, required this.lessons, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.5)),
      ),
      child: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: onClose,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 53,
                  height: 7,
                  decoration: BoxDecoration(
                    color: AppColors.kidButton,
                    borderRadius: BorderRadius.circular(4.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 36, right: 28),
                child: lessons.isEmpty
                    ? const Center(
                        child: Text(
                          'На этот день нет занятий',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.kidButton,
                            fontFamily: 'TT Norms',
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: lessons.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: LessonItem(lesson: lessons[index]),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
