import 'package:flutter/material.dart';
import '../../domain/entities/student_entity.dart';

class TopStudentsChart extends StatelessWidget {
  final List<StudentEntity> students;

  const TopStudentsChart({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    // Фильтруем студентов с 0 очков
    final studentsWithScore = students.where((s) => s.score > 0).toList();
    
    if (studentsWithScore.length < 3) {
      return _buildChartForAvailableStudents(studentsWithScore);
    }
    
    final topThreeStudents = studentsWithScore
      ..sort((a, b) => b.score.compareTo(a.score))
      ..sublist(0, 3);
    
    final maxScore = topThreeStudents.first.score.toDouble();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  left: 20,
                  bottom: 0,
                  child: _buildChartWithAvatar(topThreeStudents[1], 2, maxScore),
                ),
                Positioned(
                  bottom: 0,
                  child: _buildChartWithAvatar(topThreeStudents[0], 1, maxScore),
                ),
                Positioned(
                  right: 20,
                  bottom: 0,
                  child: _buildChartWithAvatar(topThreeStudents[2], 3, maxScore),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartForAvailableStudents(List<StudentEntity> studentsWithScore) {
    if (studentsWithScore.isEmpty) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'Нет данных для отображения',
            style: TextStyle(
              color: Color(0xFF1A237E),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    final sortedStudents = [...studentsWithScore]..sort((a, b) => b.score.compareTo(a.score));
    final maxScore = sortedStudents.first.score.toDouble();
    final studentCount = sortedStudents.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (studentCount == 1) ...[
                  Positioned(
                    bottom: 0,
                    child: _buildChartWithAvatar(sortedStudents[0], 1, maxScore),
                  ),
                ]
                else if (studentCount == 2) ...[
                  Positioned(
                    left: 60,
                    bottom: 0,
                    child: _buildChartWithAvatar(sortedStudents[0], 1, maxScore),
                  ),
                  Positioned(
                    right: 60,
                    bottom: 0,
                    child: _buildChartWithAvatar(sortedStudents[1], 2, maxScore),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartWithAvatar(StudentEntity student, int position, double maxScore) {
    final chartHeight = _calculateChartHeight(student.score, maxScore);
    final width = position == 1 ? 130.0 : 110.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, -10),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: const Color(0xFF1A237E),
                child: Text(
                  student.avatar,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 253, 253, 253),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    position.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 57, 119, 199), 
                      fontSize: 12, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: width,
          height: chartHeight,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (student.name.contains(' ')) ...[
                Text(
                  student.name.split(' ')[0],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1A237E), 
                    fontSize: 12, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  student.name.split(' ')[1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1A237E), 
                    fontSize: 12, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ] else ...[
                Text(
                  student.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1A237E), 
                    fontSize: 12, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    student.score.toString(),
                    style: const TextStyle(
                      color: Color(0xFF1A237E), 
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.bolt, color: Color(0xFF1A237E), size: 18),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _calculateChartHeight(int studentScore, double maxScore) {
    const double minHeight = 80.0;
    const double maxHeight = 160.0;

    final double percentage = studentScore / maxScore;
    return minHeight + (percentage * (maxHeight - minHeight));
  }
}