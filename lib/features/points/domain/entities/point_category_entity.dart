enum PointCategory {
  behavior('Поведение'),
  activity('Активность'),
  homework('Домашняя работа'),
  achievement('Достижения');

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
