import 'package:flutter/material.dart';
import 'package:treemov/features/kid_calendar/domain/entities/kid_event_entity.dart';

import 'kid_lesson_card.dart';

class KidLessonsList extends StatelessWidget {
  final List<KidEventEntity> lessons;

  const KidLessonsList({Key? key, required this.lessons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return const Center(child: Text('Нет занятий'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: lessons.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => KidLessonCard(event: lessons[i]),
    );
  }
}
