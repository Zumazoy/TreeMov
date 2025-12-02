enum PointCategory {
  participation('Участие'),
  behavior('Поведение'),
  achievements('Достижения'),
  homework('Домашнее задание');

  final String displayName;

  const PointCategory(this.displayName);
}

class PointAction {
  final String id;
  final PointCategory category;
  final String title;
  final String description;
  final int points;

  const PointAction({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.points,
  });
}
