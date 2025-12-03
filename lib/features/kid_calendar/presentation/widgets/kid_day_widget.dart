import 'package:flutter/material.dart';

class KidDayWidget extends StatelessWidget {
  final int day;
  final DateTime date;
  final bool hasEvents;
  final bool isSelected;
  final VoidCallback onTap;

  const KidDayWidget({
    Key? key,
    required this.day,
    required this.date,
    required this.hasEvents,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bg = isSelected ? const Color(0xFF0087CD) : Colors.transparent;
    final textColor = isSelected ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            if (hasEvents)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : const Color(0xFF004C75),
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
