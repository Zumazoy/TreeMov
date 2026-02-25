import 'package:treemov/features/kid_profile/domain/student_profile_models.dart';
import 'package:treemov/shared/data/models/accrual_response_model.dart';

class ActivityConverter {
  static ActivityItemData fromAccrual(AccrualResponseModel accrual) {
    // Определяем иконку и цвета на основе категории
    String iconPath;
    String title;

    switch (accrual.category.toLowerCase()) {
      case 'attendance':
      case 'presence':
        iconPath = 'assets/images/calendar_icon.png';
        title = 'Присутствие на занятии';
        break;
      case 'homework':
        iconPath = 'assets/images/home_icon.png';
        title = 'Выполнение домашнего задания';
        break;
      case 'project':
        iconPath = 'assets/images/medal_icon.png';
        title = 'Отличный проект';
        break;
      case 'competition':
        iconPath = 'assets/images/medal_icon.png';
        title = 'Участие в конкурсе';
        break;
      case 'behavior_negative':
      case 'passive':
        iconPath = 'assets/images/alarm.png';
        title = accrual.comment.isNotEmpty ? accrual.comment : 'Пассивность';
        break;
      default:
        iconPath = 'assets/images/energy_icon.png';
        title = accrual.comment.isNotEmpty ? accrual.comment : 'Активность';
    }

    // Форматируем дату
    final date = _formatDate(
      accrual.createdAt,
    ); // Предполагаем, что есть поле createdAt

    return ActivityItemData(
      title: title,
      date: date,
      time: _formatTime(accrual.createdAt),
      points: accrual.amount,
      iconPath: iconPath,
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  static String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
