import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';

class GroupsListScreen extends StatelessWidget {
  const GroupsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Журнал',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.notesDarkText,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Выберите группу для начисления баллов:',
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 16,
                color: AppColors.notesDarkText,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text(
                  'Система баллов готовится к подключению',
                  style: TextStyle(
                    color: AppColors.grayFieldText,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}