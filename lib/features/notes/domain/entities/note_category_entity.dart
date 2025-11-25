enum NoteCategoryEntity {
  all('Все заметки'),
  behavior('Поведение'),
  study('Учеба'),
  parents('Родители'),
  general('Общее');

  final String title;
  const NoteCategoryEntity(this.title);
}
