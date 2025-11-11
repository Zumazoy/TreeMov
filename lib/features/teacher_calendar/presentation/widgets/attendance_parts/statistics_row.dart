import 'package:flutter/material.dart';

class StatisticsRow extends StatelessWidget {
  final double availableWidth;
  final int totalStudents;
  final int presentCount;
  final int absentCount;
  final int notMarkedCount;

  const StatisticsRow({
    super.key,
    required this.availableWidth,
    required this.totalStudents,
    required this.presentCount,
    required this.absentCount,
    required this.notMarkedCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: availableWidth,
      height: 90,
      child: Row(
        children: [
          Expanded(
            child: _buildStatContainer(
              count: totalStudents,
              title: 'Всего',
              bgColor: const Color(0xFFFAF5FF),
              borderColor: const Color(0xFFE9D5FF),
              countColor: const Color(0xFF6D28D9),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatContainer(
              count: presentCount,
              title: 'Присутствует',
              bgColor: const Color(0xFFF0FDF4),
              borderColor: const Color(0xFFBBF7D0),
              countColor: const Color(0xFF15803D),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatContainer(
              count: absentCount,
              title: 'Отсутствует',
              bgColor: const Color(0xFFFEF2F2),
              borderColor: const Color(0xFFFECACA),
              countColor: const Color(0xFFB91C1C),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatContainer(
              count: notMarkedCount,
              title: 'Не отмечено',
              bgColor: const Color(0xFFF9FAFB),
              borderColor: const Color(0xFFD1D5DB),
              countColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatContainer({
    required int count,
    required String title,
    required Color bgColor,
    required Color borderColor,
    required Color countColor,
  }) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.5),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'TT Norms',
              color: countColor,
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Arial',
                color: countColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
