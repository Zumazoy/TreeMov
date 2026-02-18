import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/core/widgets/layout/child_nav_bar.dart';
import 'package:treemov/features/raiting/data/repositories/rating_repository_impl.dart';
import 'package:treemov/features/raiting/presentation/blocs/rating_bloc.dart';
import 'package:treemov/features/raiting/presentation/blocs/rating_event.dart';
import 'package:treemov/features/raiting/presentation/blocs/rating_state.dart';
import 'package:treemov/features/raiting/presentation/widgets/student_card.dart';
import 'package:treemov/features/raiting/presentation/widgets/top_students_chart.dart';
import 'package:treemov/features/teacher_calendar/presentation/screens/calendar_screen.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

class RatingScreen extends StatefulWidget {
  final DioClient dioClient;

  const RatingScreen({super.key, required this.dioClient});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late final Future<RatingBloc> _ratingBlocFuture;
  bool _showPinnedCard = true;

  @override
  void initState() {
    super.initState();
    _ratingBlocFuture = _initializeBloc();
  }

  Future<RatingBloc> _initializeBloc() async {
    final prefs = await SharedPreferences.getInstance();
    final repository = RatingRepositoryImpl(widget.dioClient, prefs);
    final bloc = RatingBloc(repository);
    bloc.add(const LoadStudentsEvent());
    bloc.add(const LoadCurrentStudentEvent());
    return bloc;
  }

  void _onNavBarTap(int index) {
    switch (index) {
      case 0:
        // Переход на календарь
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const CalendarScreen(), // Экран календаря ученика
          ),
        );
        break;
      case 1:
        // Уже на рейтинге, ничего не делаем или можно обновить
        break;
      case 2:
        // Переход в магазин
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const ShopScreen(),
        //   ),
        // );
        break;
      case 3:
        // Переход в профиль дерева
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const TreeProfileScreen(),
        //   ),
        // );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      body: FutureBuilder<RatingBloc>(
        future: _ratingBlocFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          }

          if (snapshot.hasError) {
            return _buildError('Ошибка инициализации: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return _buildLoading();
          }

          return BlocProvider<RatingBloc>(
            create: (context) => snapshot.data!,
            child: BlocBuilder<RatingBloc, RatingState>(
              builder: (context, state) {
                if (state is RatingLoading) {
                  return _buildLoading();
                } else if (state is StudentsLoaded ||
                    state is CurrentStudentLoaded) {
                  final studentsState = context.read<RatingBloc>().state;
                  List<StudentEntity> students = [];
                  StudentEntity? currentStudent;

                  if (studentsState is StudentsLoaded) {
                    students = studentsState.students;
                  }
                  if (studentsState is CurrentStudentLoaded) {
                    currentStudent = studentsState.currentStudent;
                  }

                  return _buildContent(students, currentStudent);
                } else if (state is RatingError) {
                  return _buildError(state.message);
                }
                return _buildLoading();
              },
            ),
          );
        },
      ),
      // Используем готовый компонент BottomNavigationBar
      bottomNavigationBar: ChildBottomNavigationBar(
        currentIndex: 1, // Рейтинг - второй элемент (индекс 1)
        onTap: _onNavBarTap,
      ),
    );
  }

  Widget _buildContent(
    List<StudentEntity> students,
    StudentEntity? currentStudent,
  ) {
    final sortedStudents = [...students]
      ..sort((a, b) => b.score.compareTo(a.score));
    final topThree = _getTopThree(sortedStudents);
    final currentUserPosition = _getCurrentUserPosition(
      sortedStudents,
      currentStudent,
    );

    return Stack(
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
            if (sortedStudents.isNotEmpty)
              TopStudentsChart(students: topThree)
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
        if (sortedStudents.isNotEmpty)
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
                      child: _buildStudentsList(
                        scrollController,
                        sortedStudents,
                        currentStudent,
                        currentUserPosition,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildStudentsList(
    ScrollController scrollController,
    List<StudentEntity> sortedStudents,
    StudentEntity? currentStudent,
    int currentUserPosition,
  ) {
    if (currentStudent == null ||
        !sortedStudents.any((s) => s.id == currentStudent.id)) {
      return _buildAllStudentsList(
        scrollController,
        sortedStudents,
        currentStudent,
      );
    }

    const itemHeight = 72.0;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification ||
            notification is ScrollEndNotification) {
          final scrollOffset = notification.metrics.pixels;
          final viewportHeight = notification.metrics.viewportDimension;

          final userPosition = (currentUserPosition - 1) * itemHeight;

          final userIsAboveViewport = userPosition + itemHeight <= scrollOffset;
          final userIsBelowViewport =
              userPosition >= scrollOffset + viewportHeight;

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
          _buildAllStudentsList(
            scrollController,
            sortedStudents,
            currentStudent,
          ),
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
                  student: currentStudent,
                  position: currentUserPosition,
                  isCurrentUser: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllStudentsList(
    ScrollController scrollController,
    List<StudentEntity> sortedStudents,
    StudentEntity? currentStudent,
  ) {
    return ListView.builder(
      controller: scrollController,
      itemCount: sortedStudents.length,
      itemBuilder: (context, index) {
        final student = sortedStudents[index];
        final position = index + 1;
        final isCurrentUser =
            currentStudent != null && student.id == currentStudent.id;

        return StudentCard(
          student: student,
          position: position,
          isCurrentUser: isCurrentUser,
        );
      },
    );
  }

  List<StudentEntity> _getTopThree(List<StudentEntity> sortedStudents) {
    final studentsWithScore = sortedStudents.where((s) => s.score > 0).toList();
    if (studentsWithScore.length < 3) return studentsWithScore;
    return studentsWithScore.take(3).toList();
  }

  int _getCurrentUserPosition(
    List<StudentEntity> sortedStudents,
    StudentEntity? currentStudent,
  ) {
    if (currentStudent == null) return 0;
    final index = sortedStudents.indexWhere(
      (student) => student.id == currentStudent.id,
    );
    return index != -1 ? index + 1 : 0;
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF1A237E)),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        'Ошибка: $message',
        style: const TextStyle(color: Color(0xFF1A237E), fontSize: 16),
      ),
    );
  }
}
