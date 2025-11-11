import 'package:flutter/material.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/change_schedule_screen.dart';

import '../../../../core/themes/app_colors.dart';
import '../widgets/change_event_modal.dart';
import '../widgets/delete_event_modal.dart';

class AboutEventDetailsScreen extends StatelessWidget {
  final String? eventId;
  final String groupName;
  final String activityType;
  final String location;
  final String startTime;
  final String endTime;
  final String repeat;
  final String description;

  const AboutEventDetailsScreen({
    super.key,
    this.eventId,
    required this.groupName,
    required this.activityType,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.description,
  });

  DateTime _parseTime(String timeStr) {
    final now = DateTime.now();
    final timeParts = timeStr.split(':');
    if (timeParts.length == 2) {
      return DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    }
    return now;
  }

  void _navigateToEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEventScreen(
          eventId: eventId ?? 'temp_${DateTime.now().millisecondsSinceEpoch}',
          initialGroup: groupName,
          initialLessonType: activityType,
          initialLocation: location,
          initialStartDateTime: _parseTime(startTime),
          initialEndDateTime: _parseTime(endTime),
          initialRepeat: repeat,
          initialReminder: 'Добавить напоминание',
          initialDescription: description,
        ),
      ),
    );
  }

  void _showChangeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: ChangeEventModal(
          onOptionSelected: (selectedOption) {
            // Здесь будет логика для BLoC
            // Выбранный вариант: selectedOption

            // Переходим на экран редактирования после выбора
            _navigateToEditScreen(context);
          },
        ),
      ),
    );
  }

  void _showDeleteModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          Padding(padding: const EdgeInsets.all(20), child: DeleteEventModal()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.teacherPrimary,
        automaticallyImplyLeading: false,
        title: const Text(
          'Событие',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w900,
            fontSize: 20,
            height: 1.0,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 367,
                      constraints: const BoxConstraints(minHeight: 320),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.eventTap, width: 1),
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              groupName,
                              style: const TextStyle(
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                height: 1.2,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          _buildInfoRow(
                            iconPath: 'assets/images/activity_icon.png',
                            text: activityType,
                          ),
                          const SizedBox(height: 12),

                          _buildInfoRow(
                            iconPath: 'assets/images/place_icon.png',
                            text: location,
                          ),
                          const SizedBox(height: 16),

                          _buildTimeSection(),
                          const SizedBox(height: 16),

                          _buildInfoRow(
                            iconPath: 'assets/images/repeat_icon.png',
                            text: repeat,
                          ),
                          const SizedBox(height: 12),

                          _buildInfoRow(
                            iconPath: 'assets/images/bell_icon.png',
                            text: 'Добавить напоминание',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      width: 367,
                      constraints: const BoxConstraints(minHeight: 120),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.eventTap, width: 1),
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            iconPath: 'assets/images/desc_icon.png',
                            text: 'Описание',
                          ),
                          const SizedBox(height: 12),
                          Text(
                            description.isNotEmpty
                                ? description
                                : 'Описание события отсутствует',
                            style: const TextStyle(
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.4,
                              color: AppColors.grayFieldText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(
                    text: 'Изменить',
                    icon: Icons.edit,
                    onPressed: () => _showChangeModal(context),
                  ),

                  const SizedBox(width: 16),

                  _buildActionButton(
                    text: 'Удалить',
                    icon: Icons.delete,
                    onPressed: () => _showDeleteModal(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required String iconPath, required String text}) {
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 20,
            height: 20,
            color: AppColors.grayFieldText,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.2,
                color: AppColors.grayFieldText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSection() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.eventTap, width: 1),
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/clock_icon.png',
                    width: 20,
                    height: 20,
                    color: AppColors.grayFieldText,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Начало:',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.0,
                      color: AppColors.grayFieldText,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    startTime,
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.0,
                      color: AppColors.grayFieldText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 1, color: AppColors.eventTap),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    'Конец:',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.0,
                      color: AppColors.grayFieldText,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    endTime,
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.0,
                      color: AppColors.grayFieldText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 90,
      height: 61,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.5),
            side: BorderSide(color: AppColors.eventTap, width: 1),
          ),
          elevation: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.black),
            const SizedBox(height: 5),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
