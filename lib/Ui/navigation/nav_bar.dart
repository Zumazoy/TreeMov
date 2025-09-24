import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF75D0FF),
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Календарь',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard_outlined),
          activeIcon: Icon(Icons.leaderboard),
          label: 'Рейтинг',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Магазин',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}