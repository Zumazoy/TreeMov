import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/features/accrual_points/presentation/bloc/accrual_bloc.dart';
import 'package:treemov/shared/data/models/student_group_response_model.dart';

import '../../../../core/themes/app_colors.dart';
import 'students_points_list_screen.dart';

class GroupsListScreen extends StatelessWidget {
  const GroupsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccrualBloc>()..add(LoadStudentGroups()),
      child: const _GroupsListScreenContent(),
    );
  }
}

class _GroupsListScreenContent extends StatefulWidget {
  const _GroupsListScreenContent();

  @override
  State<_GroupsListScreenContent> createState() => _GroupsListScreenState();
}

class _GroupsListScreenState extends State<_GroupsListScreenContent> {
  List<StudentGroupResponseModel> _groups = [];

  void _onGroupTap(StudentGroupResponseModel group, BuildContext context) {
    final accrualBloc = context.read<AccrualBloc>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: accrualBloc,
          child: StudentsPointsListScreen(
            group: group,
            accrualBloc: accrualBloc,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccrualBloc, AccrualState>(
      listener: (context, state) {
        if (state is GroupsLoaded) {
          setState(() {
            _groups = state.groups;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/stars_filled_icon.png',
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.star,
                      color: AppColors.notesDarkText,
                      size: 24,
                    );
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'Журнал',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.notesDarkText,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.white,
            elevation: 0,
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Выберите группу для начисления баллов:',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 16,
                    color: AppColors.notesDarkText,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildContent(state)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(AccrualState state) {
    if (state is AccrualLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AccrualError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.directoryTextSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Ошибка загрузки',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.grayFieldText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.directoryTextSecondary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  context.read<AccrualBloc>().add(LoadStudentGroups()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teacherPrimary,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Попробовать снова'),
            ),
          ],
        ),
      );
    }

    if (_groups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.group_outlined,
              size: 64,
              color: AppColors.directoryTextSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Нет доступных групп',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.grayFieldText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Группы появятся после их создания',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.directoryTextSecondary,
              ),
            ),
          ],
        ),
      );
    }

    // Показываем список групп
    return ListView.builder(
      itemCount: _groups.length,
      itemBuilder: (context, index) {
        final group = _groups[index];
        return _buildGroupItem(context, group);
      },
    );
  }

  Widget _buildGroupItem(
    BuildContext context,
    StudentGroupResponseModel group,
  ) {
    return GestureDetector(
      onTap: () => _onGroupTap(group, context),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.directoryBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Группа ${group.name ?? "Без названия"}',
                    style: const TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.notesDarkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/team_icon.png',
                        width: 16,
                        height: 16,
                        color: AppColors.directoryTextSecondary,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.people,
                            color: AppColors.directoryTextSecondary,
                            size: 16,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${group.students.length} учеников',
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 14,
                          color: AppColors.directoryTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/purple_arrow.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.directoryTextSecondary,
                  size: 20,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
