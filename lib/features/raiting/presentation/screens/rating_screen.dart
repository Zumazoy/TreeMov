import 'dart:async';
import 'package:flutter/material.dart';
import 'package:treemov/core/network/dio_client.dart';
import '../widgets/student_card.dart';
import '../widgets/top_students_chart.dart';
import '../../domain/entities/student_entity.dart';
import '../../data/repositories/rating_repository_impl.dart';

class RatingScreen extends StatefulWidget {
  final DioClient dioClient;

  const RatingScreen({super.key, required this.dioClient});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  List<StudentEntity> _allStudents = [];
  StudentEntity? _currentStudent;
  late final RatingRepositoryImpl _repository;
  bool _isLoading = true;
  bool _showPinnedCard = true;

  @override
  void initState() {
    super.initState();
    _repository = RatingRepositoryImpl(widget.dioClient);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final students = await _repository.getStudents();
      final currentStudent = await _repository.getCurrentStudent();
      
      setState(() {
        _allStudents = students;
        _currentStudent = currentStudent;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<StudentEntity> get _sortedStudents => [..._allStudents]..sort((a, b) => b.score.compareTo(a.score));
  List<StudentEntity> get _topThree => _sortedStudents.take(3).toList();

  int get _currentUserPosition {
    if (_currentStudent == null) return 0;
    return _sortedStudents.indexWhere((student) => student.name == _currentStudent!.name) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      body: Stack(
        children: [
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(1.0),
                    Colors.white.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.3],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/images/background_raiting.png',
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Рейтинг',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 20, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                elevation: 0,
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFF1A237E)),
                  ),
                )
              else if (_sortedStudents.isNotEmpty)
                TopStudentsChart(students: _topThree)
              else
                const Expanded(
                  child: Center(
                    child: Text(
                      'Нет данных о студентах',
                      style: TextStyle(color: Color(0xFF1A237E), fontSize: 16),
                    ),
                  ),
                ),
            ],
          ),

          if (!_isLoading && _sortedStudents.isNotEmpty)
            DraggableScrollableSheet(
              initialChildSize: 0.45,
              minChildSize: 0.45,
              maxChildSize: 0.87,
              snap: true,
              snapSizes: const [0.45, 0.85],
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 16,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 14, bottom: 4),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1A237E),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: _buildStudentsList(scrollController),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildStudentsList(ScrollController scrollController) {
    if (_currentStudent == null || !_sortedStudents.any((s) => s.name == _currentStudent!.name)) {
      return _buildAllStudentsList(scrollController);
    }
    
    final currentUser = _sortedStudents.firstWhere((student) => student.name == _currentStudent!.name);
    final currentUserIndex = _sortedStudents.indexWhere((student) => student.name == _currentStudent!.name);
    const itemHeight = 72.0;
    
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification || notification is ScrollEndNotification) {
          final scrollOffset = notification.metrics.pixels;
          final viewportHeight = notification.metrics.viewportDimension;
          
          final userPosition = currentUserIndex * itemHeight;
          
          final userIsAboveViewport = userPosition + itemHeight <= scrollOffset;
          final userIsBelowViewport = userPosition >= scrollOffset + viewportHeight;
          
          final shouldShowPinned = userIsAboveViewport || userIsBelowViewport;
          
          if (_showPinnedCard != shouldShowPinned) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _showPinnedCard = shouldShowPinned;
                });
              }
            });
          }
        }
        return false;
      },
      child: Stack(
        children: [
          _buildAllStudentsList(scrollController),
          
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedOpacity(
              opacity: _showPinnedCard ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: StudentCard(
                  student: currentUser,
                  position: _currentUserPosition,
                  isCurrentUser: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllStudentsList(ScrollController scrollController) {
    return ListView.builder(
      controller: scrollController,
      itemCount: _sortedStudents.length,
      itemBuilder: (context, index) {
        final student = _sortedStudents[index];
        final position = index + 1;
        final isCurrentUser = _currentStudent != null && student.name == _currentStudent!.name;
        
        return StudentCard(
          student: student,
          position: position,
          isCurrentUser: isCurrentUser,
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavIcon('assets/images/calendar_icon.png'),
          _buildNavIcon('assets/images/raiting_icon.png', isActive: true),
          _buildNavIcon('assets/images/shop_icon.png'),
          _buildNavIcon('assets/images/tree_profile.png'),
        ],
      ),
    );
  }

  Widget _buildNavIcon(String iconPath, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: isActive 
          ? BoxDecoration(
              color: const Color(0xFF1A237E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: Image.asset(
        iconPath,
        width: 32,
        height: 32,
        color: isActive ? const Color(0xFF1A237E) : Colors.grey,
      ),
    );
  }
}