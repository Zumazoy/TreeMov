import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_card.dart';
import 'package:treemov/features/kid_profile/presentation/widgets/student_settings_toggle_row.dart';

class StudentSettingsSystemSection extends StatelessWidget {
  final bool soundEnabled;
  final bool autoSaveEnabled;
  final bool offlineModeEnabled; // Новый параметр
  final ValueChanged<bool> onSoundChanged;
  final ValueChanged<bool> onAutoSaveChanged;
  final ValueChanged<bool> onOfflineModeChanged; // Новый параметр

  const StudentSettingsSystemSection({
    super.key,
    required this.soundEnabled,
    required this.autoSaveEnabled,
    required this.offlineModeEnabled,
    required this.onSoundChanged,
    required this.onAutoSaveChanged,
    required this.onOfflineModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 12, bottom: 4),
          child: Row(
            children: [
              Icon(Icons.settings_outlined, size: 24, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Система',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        StudentSettingsCard(
          children: [
            StudentSettingsToggleRow(
              title: 'Звуки',
              subtitle: 'Воспроизводить звуки уведомлений',
              value: soundEnabled,
              onChanged: onSoundChanged,
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            StudentSettingsToggleRow(
              title: 'Автосохранение',
              subtitle: 'Автоматически сохранять изменения',
              value: autoSaveEnabled,
              onChanged: onAutoSaveChanged,
            ),
            const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.eventTap,
            ),
            StudentSettingsToggleRow(
              title: 'Офлайн-режим',
              subtitle: 'Работа без интернета',
              value: offlineModeEnabled,
              onChanged: onOfflineModeChanged,
            ),
          ],
        ),
      ],
    );
  }
}
