import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unselectedColor = Colors.grey[600]!;
    final selectedColor = const Color(0xFF75D0FF);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      showSelectedLabels: true,
      showUnselectedLabels: true,

      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/calendar_icon.png',
            width: 24,
            height: 24,
            color: unselectedColor,
          ),
          activeIcon: Image.asset(
            'assets/images/calendar_icon.png',
            width: 24,
            height: 24,
            color: selectedColor,
          ),
          label: 'Календарь',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/leaderboard_icon.png',
            width: 24,
            height: 24,
            color: unselectedColor,
          ),
          activeIcon: Image.asset(
            'assets/images/leaderboard_icon.png',
            width: 24,
            height: 24,
            color: selectedColor,
          ),
          label: 'Рейтинг',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/shop_icon.png',
            width: 24,
            height: 24,
            color: unselectedColor,
          ),
          activeIcon: Image.asset(
            'assets/images/shop_icon.png',
            width: 24,
            height: 24,
            color: selectedColor,
          ),
          label: 'Магазин',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/tree_profile.png',
            width: 24,
            height: 24,
            color: unselectedColor,
          ),
          activeIcon: Image.asset(
            'assets/images/tree_profile.png',
            width: 24,
            height: 24,
            color: selectedColor,
          ),
          label: 'Профиль',
        ),
      ],
    );
  }
}
