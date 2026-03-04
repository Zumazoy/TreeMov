import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treemov/core/network/dio_client.dart';
import 'package:treemov/core/themes/app_colors.dart';
import 'package:treemov/features/raiting/data/repositories/rating_repository_impl.dart';
import 'package:treemov/features/raiting/presentation/blocs/rating_bloc.dart';
import 'package:treemov/features/raiting/presentation/blocs/rating_event.dart';
import 'package:treemov/features/raiting/presentation/blocs/rating_state.dart';
import 'package:treemov/features/raiting/presentation/widgets/group_selector.dart';
import 'package:treemov/features/raiting/presentation/widgets/loading_error_widgets.dart';
import 'package:treemov/features/raiting/presentation/widgets/rating_app_bar.dart';
import 'package:treemov/features/raiting/presentation/widgets/rating_background.dart';
import 'package:treemov/features/raiting/presentation/widgets/students_draggable_sheet.dart';
import 'package:treemov/features/raiting/presentation/widgets/top_students_section.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

class RatingScreen extends StatefulWidget {
  final DioClient dioClient;

  const RatingScreen({super.key, required this.dioClient});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late RatingBloc _ratingBloc;
  bool _showPinnedCard = true;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    debugPrint('RatingScreen: initState');
    _initializeBloc();
  }

  void _initializeBloc() {
    SharedPreferences.getInstance().then((prefs) {
      final repository = RatingRepositoryImpl(widget.dioClient, prefs);
      _ratingBloc = RatingBloc(repository);
      _isInitialized = true;
      _loadData();
      if (mounted) setState(() {});
    });
  }

  void refreshData() {
    debugPrint('RatingScreen: refreshData вызван');
    if (_isInitialized) {
      _loadData();
    }
  }

  void _loadData() {
    debugPrint('RatingScreen: загружаем данные');
    _ratingBloc.add(const LoadStudentGroupsEvent());
    _ratingBloc.add(const LoadCurrentStudentEvent());
  }

  @override
  void dispose() {
    debugPrint('RatingScreen: dispose');
    _ratingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const RatingLoadingWidget();
    }

    return BlocProvider<RatingBloc>.value(
      value: _ratingBloc,
      child: BlocBuilder<RatingBloc, RatingState>(
        builder: (context, state) {
          if (state is RatingLoading) {
            return const RatingLoadingWidget();
          } else if (state is StudentsLoaded) {
            return _buildContent(state);
          } else if (state is RatingError) {
            return RatingErrorWidget(message: state.message);
          }
          return const RatingLoadingWidget();
        },
      ),
    );
  }

  Widget _buildContent(StudentsLoaded state) {
    final sortedStudents = [...state.students]
      ..sort((a, b) => b.score.compareTo(a.score));
    final currentUserPosition = _getCurrentUserPosition(
      sortedStudents,
      state.currentStudent,
    );

    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: RatingBackground(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                debugPrint('RatingScreen: ручное обновление');
                if (state.selectedGroup != null) {
                  _ratingBloc.add(
                    LoadStudentsForGroupEvent(state.selectedGroup!),
                  );
                } else {
                  _loadData();
                }
                await Future.delayed(const Duration(milliseconds: 500));
              },
              color: const Color(0xFF1A237E),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const RatingAppBar(),
                        if (state.groups.isNotEmpty)
                          GroupSelector(
                            groups: state.groups,
                            selectedGroup: state.selectedGroup,
                            onGroupSelected: (group) {
                              _ratingBloc.add(ChangeGroupEvent(group));
                            },
                          ),
                        const SizedBox(height: 16), // Уменьшаем отступ
                        TopStudentsSection(students: sortedStudents),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (sortedStudents.isNotEmpty)
              StudentsDraggableSheet(
                students: sortedStudents,
                currentStudent: state.currentStudent,
                currentUserPosition: currentUserPosition,
                showPinnedCard: _showPinnedCard,
                onPinnedCardVisibilityChanged: (visible) {
                  if (mounted) {
                    setState(() {
                      _showPinnedCard = visible;
                    });
                  }
                },
              ),
          ],
        ),
      ),
    );
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
}
