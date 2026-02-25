import '../domain/kid_profile_models.dart';

class KidProfileTestData {
  static const List<AchievementChipData> achievements = [
    AchievementChipData(
      label: 'Первый шаг',
      iconPath: 'assets/images/achievement_icon.png',
    ),
    AchievementChipData(
      label: 'Инноватор',
      iconPath: 'assets/images/lightbulb_icon.png',
    ),
    AchievementChipData(label: 'Герой', iconPath: 'assets/images/swords.png'),
    AchievementChipData(
      label: 'Гений',
      iconPath: 'assets/images/brain_circuit.png',
    ),
    AchievementChipData(
      label: 'Квестер',
      iconPath: 'assets/images/brain_circuit.png',
    ),
    AchievementChipData(
      label: 'Lvl up',
      iconPath: 'assets/images/double_arrow.png',
    ),
    AchievementChipData(
      label: 'Полное погружение',
      iconPath: 'assets/images/lucide_bubbles.png',
    ),
    AchievementChipData(
      label: 'Мастер энергий',
      iconPath: 'assets/images/shield_energy.png',
    ),
    AchievementChipData(
      label: 'Командный игрок',
      iconPath: 'assets/images/team_circle.png',
    ),
    AchievementChipData(
      label: 'Защитник дерева',
      iconPath: 'assets/images/tree_line.png',
    ),
  ];

  static const Map<String, String> achievementDescriptions = {
    'Первый шаг':
        'Присуждается за первый вход в приложение и настройку профиля',
    'Инноватор': 'За создание уникального проекта',
    'Герой': 'За переход на 4 уровень развития',
    'Гений': 'За успешное выполнение 20 домашних заданий',
    'Квестер': 'За прохождение 5 специальных квестов',
    'Lvl up': 'За переход на новый уровень',
    'Полное погружение':
        'За посещение всех занятий и активное участие в течение месяца',
    'Мастер энергий':
        'За накопление 500 энергий за посещение и работу на занятиях',
    'Командный игрок': 'За участие в 3 групповых проектах или соревнованиях',
    'Защитник дерева': 'За успешную защиту дерева от 10 атак с помощью энергий',
  };

  static const Map<String, String> achievementDates = {
    'Первый шаг': '12.01.2024',
    'Инноватор': '15.03.2024',
    'Герой': '01.05.2024',
    'Гений': '10.04.2024',
    'Квестер': '20.02.2024',
    'Lvl up': '18.02.2024',
    'Полное погружение': '30.01.2024',
    'Мастер энергий': '20.02.2024',
    'Командный игрок': '22.03.2024',
    'Защитник дерева': '05.04.2024',
  };

  static const List<ActivityItemData> activities = [
    ActivityItemData(
      title: 'Пассивность',
      date: '15.05.2025',
      time: '21:46',
      points: -4,
      iconPath: 'assets/images/alarm.png',
    ),
    ActivityItemData(
      title: 'Присутствие на занятии',
      date: '12.01.2024',
      time: '09:15',
      points: 5,
      iconPath: 'assets/images/calendar_icon.png',
    ),
    ActivityItemData(
      title: '1 место в конкурсе',
      date: '18.06.2025',
      time: '21:30',
      points: 10,
      iconPath: 'assets/images/medal_icon.png',
    ),
    ActivityItemData(
      title: 'Выполнение домашнего задания',
      date: '10.01.2024',
      time: '14:20',
      points: 15,
      iconPath: 'assets/images/home_icon.png',
    ),
    ActivityItemData(
      title: 'Присутствие на занятии',
      date: '12.04.2024',
      time: '09:15',
      points: 5,
      iconPath: 'assets/images/calendar_icon.png',
    ),
    ActivityItemData(
      title: 'Мешал проведению занятия',
      date: '18.03.2025',
      time: '21:38',
      points: -8,
      iconPath: 'assets/images/alarm.png',
    ),
    ActivityItemData(
      title: 'Присутствие на занятии',
      date: '12.01.2024',
      time: '09:15',
      points: 5,
      iconPath: 'assets/images/calendar_icon.png',
    ),
    ActivityItemData(
      title: 'Отличное выполнение домашнего задания',
      date: '10.01.2024',
      time: '14:20',
      points: 20,
      iconPath: 'assets/images/home_icon.png',
    ),
    ActivityItemData(
      title: 'Отличный проект',
      date: '18.12.2024',
      time: '21:30',
      points: 25,
      iconPath: 'assets/images/medal_icon.png',
    ),
    ActivityItemData(
      title: 'Призовое место в конкурсе',
      date: '18.06.2025',
      time: '21:30',
      points: 5,
      iconPath: 'assets/images/medal_icon.png',
    ),
  ];

  static const Map<String, dynamic> profileData = {
    'name': 'Антон Вахтин',
    'level': 3,
    'levelTitle': 'Опытный',
    'currentExp': 178,
    'nextLevelExp': 300,
    'totalEarnings': 201,
    'attendance': 95,
    'achievementsCount': 4,
  };
}
