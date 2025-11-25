enum NoteCategoryEntity {
  all('Все заметки'),
  behavior('Поведение'),
  study('Учеба'),
  parents('Родители'),
  general('Общее');

  final String title;
  const NoteCategoryEntity(this.title);
}

extension NoteCategoryApiMapper on NoteCategoryEntity {
  /// Преобразование enum в строку для API
  String get apiValue {
    switch (this) {
      case NoteCategoryEntity.behavior:
        return "behavior";
      case NoteCategoryEntity.study:
        return "learning";
      case NoteCategoryEntity.parents:
        return "parents";
      case NoteCategoryEntity.general:
        return "general";
      case NoteCategoryEntity.all:
        return "";
    }
  }

  /// Преобразование строки API в enum
  static NoteCategoryEntity fromApi(String value) {
    switch (value) {
      case "behavior":
        return NoteCategoryEntity.behavior;
      case "learning":
        return NoteCategoryEntity.study;
      case "parents":
        return NoteCategoryEntity.parents;
      case "general":
        return NoteCategoryEntity.general;
      default:
        return NoteCategoryEntity.all;
    }
  }
}
