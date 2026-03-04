import 'package:flutter/material.dart';

class RatingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RatingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          'Рейтинг',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 40,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
