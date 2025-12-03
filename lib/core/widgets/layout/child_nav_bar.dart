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

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: Colors.transparent,
      unselectedItemColor: unselectedColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 8,
      items: [
        _buildNavItem(
          iconPath: 'assets/images/calendar_icon.png',
          isSelected: currentIndex == 0,
          unselectedColor: unselectedColor,
          gradient: selectedGradient,
        ),
        _buildNavItem(
          iconPath: 'assets/images/leaderboard_icon.png',
          isSelected: currentIndex == 1,
          unselectedColor: unselectedColor,
          gradient: selectedGradient,
        ),
        _buildNavItem(
          iconPath: 'assets/images/shop_icon.png',
          isSelected: currentIndex == 2,
          unselectedColor: unselectedColor,
          gradient: selectedGradient,
        ),
        _buildNavItem(
          iconPath: 'assets/images/tree_profile.png',
          isSelected: currentIndex == 3,
          unselectedColor: unselectedColor,
          gradient: selectedGradient,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required bool isSelected,
    required Color unselectedColor,
    required Gradient gradient,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: isSelected ? null : unselectedColor,
      ),
      activeIcon: ShaderMask(
        shaderCallback: (bounds) => gradient.createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: Image.asset(
          iconPath,
          width: 24,
          height: 24,
          color: Colors.white,
        ),
      ),
      label: '',
    );
  }
}
