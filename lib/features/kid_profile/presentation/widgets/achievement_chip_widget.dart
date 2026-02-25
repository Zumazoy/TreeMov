import 'package:flutter/material.dart';

class AchievementChipWidget extends StatelessWidget {
  final String label;
  final String iconPath;
  final Color backgroundColor;

  const AchievementChipWidget({
    super.key,
    required this.label,
    required this.iconPath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 18, height: 18, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'TT Norms',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
