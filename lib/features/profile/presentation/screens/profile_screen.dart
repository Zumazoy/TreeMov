import 'package:flutter/material.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/widgets/auth/logout_dialog.dart';

import '../../../../core/themes/app_colors.dart';
import '../../data/mocks/mock_profile_data.dart';
import '../widgets/daily_schedule_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/rep_nots_buttons.dart';
import '../widgets/settings_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showSettingsMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          alignment: Alignment.topRight,
          insetPadding: const EdgeInsets.only(top: 60, right: 16),
          child: SettingsMenu(
            onEditData: () {
              Navigator.pop(context);
              // редактирование данных
            },
            onChangePassword: () {
              Navigator.pop(context);
              // смена пароля
            },
            onSettings: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.settings);
              // настройки
            },
            onLogout: () {
              Navigator.pop(context);
              LogoutDialog.show(context: context);
              //  выход
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final teacher = MockProfileData.mockTeacher;
    final dailySchedule = MockProfileData.mockDailySchedule;

    return Scaffold(
      backgroundColor: AppColors.notesBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/grad_logo.png',
          height: 30,
          fit: BoxFit.contain,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.notesDarkText),
            onPressed: () => _showSettingsMenu(context),
          ),
        ],
      ),
      body: Column(
        children: [
          ProfileHeader(teacher: teacher),
          Container(height: 1, color: AppColors.eventTap),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DailyScheduleCard(dailySchedule: dailySchedule),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.notesBackground,
            child: RepNotsButtons(),
          ),
        ],
      ),
    );
  }
}
