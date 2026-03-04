import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class ChildBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ChildBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unselectedColor = AppColors.grey;
    final selectedGradient = const LinearGradient(
      colors: [Color(0xFF19BCDB), Color(0xFF741CDB)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(
            horizontal: 65,
          ), // Отступы по бокам
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                iconPath: 'assets/images/calendar_icon.png',
                isSelected: currentIndex == 0,
                unselectedColor: unselectedColor,
                gradient: selectedGradient,
                onTap: () => onTap(0),
              ),
              const SizedBox(width: 20),
              _buildNavItem(
                iconPath: 'assets/images/leaderboard_icon.png',
                isSelected: currentIndex == 1,
                unselectedColor: unselectedColor,
                gradient: selectedGradient,
                onTap: () => onTap(1),
              ),
              const SizedBox(width: 20),
              _buildNavItem(
                iconPath: 'assets/images/tree_profile.png',
                isSelected: currentIndex == 2,
                unselectedColor: unselectedColor,
                gradient: selectedGradient,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required bool isSelected,
    required Color unselectedColor,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Center(
          child: isSelected
              ? ShaderMask(
                  shaderCallback: (bounds) => gradient.createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: Image.asset(iconPath, width: 24, height: 24),
                )
              : Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  color: unselectedColor,
                ),
        ),
      ),
    );
  }
}
