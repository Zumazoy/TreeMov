import 'package:treemov/features/kid_profile/domain/student_profile_models.dart';
import 'package:treemov/shared/data/models/accrual_response_model.dart';

class ActivityConverter {
  static ActivityItemData fromAccrual(AccrualResponseModel accrual) {
    print('🔄 Конвертация начисления ID: ${accrual.id}');

    String iconPath;
    String title;

    final category = accrual.category.toLowerCase();
    print('   Категория: $category, комментарий: ${accrual.comment}');
    switch (category) {
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
      case 'participation':
        iconPath = 'assets/images/team_icon.png';
        title = accrual.comment.isNotEmpty
            ? accrual.comment
            : 'Активность на занятии';
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

    print('   → Результат: $title, ${accrual.amount} баллов');

    return ActivityItemData(
      title: title,
      points: accrual.amount,
      iconPath: iconPath,
    );
  }
}
