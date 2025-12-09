import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/profile/presentation/widgets/settings_card.dart';
import 'package:treemov/features/profile/presentation/widgets/settings_section_title.dart';
import 'package:treemov/features/profile/presentation/widgets/settings_toggle_row.dart';

class SettingsSystemSection extends StatelessWidget {
  final bool soundEnabled;
  final bool autoSaveEnabled;
  final ValueChanged<bool> onSoundChanged;
  final ValueChanged<bool> onAutoSaveChanged;

  const SettingsSystemSection({
    super.key,
    required this.soundEnabled,
    required this.autoSaveEnabled,
    required this.onSoundChanged,
    required this.onAutoSaveChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingsSectionTitle(
          title: 'Система',
          icon: Icons.settings_outlined,
        ),
        SettingsCard(
          children: [
            SettingsToggleRow(
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
            SettingsToggleRow(
              title: 'Автосохранение',
              subtitle: 'Автоматически сохранять изменения',
              value: autoSaveEnabled,
              onChanged: onAutoSaveChanged,
            ),
          ],
        ),
      ],
    );
  }
}
