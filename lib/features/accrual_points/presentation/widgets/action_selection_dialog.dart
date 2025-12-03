import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/features/accrual_points/data/models/accrual_request_model.dart';
import 'package:treemov/features/accrual_points/presentation/bloc/accrual_bloc.dart';
import 'package:treemov/shared/domain/entities/student_entity.dart';

import '../../../../core/themes/app_colors.dart';
import '../../data/mocks/mock_points_data.dart';
import '../../domain/entities/point_category_entity.dart';
import 'category_buttons.dart';
import 'custom_action_form.dart';
import 'student_header.dart';

class ActionSelectionDialog extends StatefulWidget {
  final StudentEntity student;
  final AccrualBloc accrualBloc;

  const ActionSelectionDialog({
    super.key,
    required this.student,
    required this.accrualBloc,
  });

  @override
  State<ActionSelectionDialog> createState() => _ActionSelectionDialogState();
}

class _ActionSelectionDialogState extends State<ActionSelectionDialog> {
  PointCategory? _selectedCategory;
  PointAction? _selectedAction;
  List<PointAction> _currentActions = [];
  bool _showCustomAction = false;
  int? _teacherProfileId;
  bool _isLoadingProfile = false;

  @override
  void initState() {
    super.initState();
    _updateActions();

    // Загружаем ID профиля учителя при инициализации диалога
    _loadTeacherProfileId();
  }

  void _loadTeacherProfileId() {
    setState(() {
      _isLoadingProfile = true;
    });

    // Проверяем, есть ли уже загруженный ID в BLoC
    if (widget.accrualBloc.teacherProfileId != null) {
      setState(() {
        _teacherProfileId = widget.accrualBloc.teacherProfileId;
        _isLoadingProfile = false;
      });
    } else {
      // Если нет, загружаем
      widget.accrualBloc.add(LoadTeacherProfileId());
    }
  }

  void _updateActions() {
    if (_selectedCategory != null) {
      _currentActions = MockPointsData.getActionsByCategory(_selectedCategory!);
    } else {
      _currentActions = [];
    }
  }

  void _onCategorySelected(PointCategory category) {
    setState(() {
      _selectedCategory = category;
      _selectedAction = null;
      _showCustomAction = false;
      _updateActions();
    });
  }

  void _onActionSelected(PointAction action) {
    setState(() {
      _selectedAction = action;
      _showCustomAction = false;
    });
  }

  void _onCustomActionSelected() {
    setState(() {
      _showCustomAction = true;
      _selectedAction = null;
    });
  }

  void _onSaveCustomAction(String title, String description, int points) {
    final customAction = PointAction(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      category: _selectedCategory!,
      title: title,
      description: description,
      points: points,
    );

    setState(() {
      _selectedAction = customAction;
      _showCustomAction = false;
    });
  }

  void _onCancelCustomAction() {
    setState(() {
      _showCustomAction = false;
    });
  }

  void _onClose() {
    Navigator.of(context).pop();
  }

  void _createAccrual() {
    if (_selectedAction != null) {
      if (_teacherProfileId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Загрузка профиля учителя...'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Создаем AccrualRequestModel
      final request = AccrualRequestModel(
        teacherProfile: _teacherProfileId!,
        student: widget.student.id ?? 0,
        amount: _selectedAction!.points,
        category: _selectedAction!.category.name,
        comment: _selectedAction!.title,
      );

      // Отправляем событие с request моделью
      widget.accrualBloc.add(CreateAccrual(request));

      // Закрываем диалог и передаем действие для показа снекбара
      Navigator.of(context).pop(_selectedAction);
    }
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccrualBloc, AccrualState>(
      bloc: widget.accrualBloc,
      listener: (context, state) {
        if (state is TeacherProfileIdLoaded) {
          setState(() {
            _teacherProfileId = state.teacherProfileId;
            _isLoadingProfile = false;
          });
        } else if (state is AccrualError) {
          setState(() {
            _isLoadingProfile = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ошибка: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Dialog(
        backgroundColor: AppColors.notesBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StudentHeader(student: widget.student, onClose: _onClose),

              const SizedBox(height: 16),

              if (_isLoadingProfile) ...[
                _buildLoadingState(),
                const SizedBox(height: 16),
              ],

              const Text(
                'Категория:',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  color: AppColors.directoryTextSecondary,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 8),

              CategoryButtons(
                selectedCategory: _selectedCategory,
                onCategorySelected: _onCategorySelected,
              ),

              const SizedBox(height: 16),

              if (_selectedCategory != null && !_showCustomAction) ...[
                const Text(
                  'Действие:',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    color: AppColors.directoryTextSecondary,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 8),

                _buildActionsList(),
              ],

              if (_showCustomAction) ...[
                CustomActionForm(
                  onSave: _onSaveCustomAction,
                  onCancel: _onCancelCustomAction,
                ),
              ],

              const SizedBox(height: 16),

              _buildConfirmationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionsList() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _currentActions.length + 1,
        itemBuilder: (context, index) {
          if (index < _currentActions.length) {
            final action = _currentActions[index];
            return _buildActionItem(action);
          } else {
            return _buildCustomActionItem();
          }
        },
      ),
    );
  }

  Widget _buildActionItem(PointAction action) {
    final isPositive = action.points > 0;
    final isZero = action.points == 0;
    final isSelected = _selectedAction?.id == action.id;

    final chipBgColor = isPositive
        ? AppColors.statsTotalBg
        : isZero
        ? AppColors.eventTap
        : const Color(0xFFFADFDF);

    final chipTextColor = isPositive
        ? AppColors.statsTotalText
        : isZero
        ? AppColors.teacherPrimary
        : const Color(0xFFDC2626);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: isSelected ? AppColors.eventTap : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected
              ? AppColors.teacherPrimary
              : AppColors.directoryBorder,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        title: Text(
          action.title,
          style: const TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppColors.notesDarkText,
          ),
        ),
        subtitle: Text(
          action.description,
          style: const TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.grayFieldText,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: chipBgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '${isPositive ? '+' : ''}${action.points}',
            style: TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: chipTextColor,
              height: 1.0,
            ),
          ),
        ),
        onTap: () => _onActionSelected(action),
      ),
    );
  }

  Widget _buildCustomActionItem() {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.directoryBorder, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.eventTap,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.add, color: AppColors.teacherPrimary),
        ),
        title: const Text(
          'Создать действие',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppColors.notesDarkText,
          ),
        ),
        subtitle: const Text(
          'Настроить свое действие',
          style: TextStyle(
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.grayFieldText,
          ),
        ),
        onTap: _onCustomActionSelected,
      ),
    );
  }

  Widget _buildConfirmationButtons() {
    final isButtonDisabled = _selectedAction == null || _isLoadingProfile;
    final buttonText = _isLoadingProfile
        ? 'Загрузка...'
        : _selectedAction == null
        ? 'Выберите действие'
        : 'Подтвердить ${_selectedAction!.points > 0 ? '+' : ''}${_selectedAction!.points}';

    // Определяем цвет кнопки в зависимости от количества баллов
    Color buttonColor;
    if (isButtonDisabled) {
      buttonColor = AppColors.lightGrey;
    } else if (_selectedAction!.points > 0) {
      buttonColor = Colors.green;
    } else if (_selectedAction!.points < 0) {
      buttonColor = const Color(0xFFDC2626);
    } else {
      buttonColor = AppColors.teacherPrimary;
    }

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _onClose,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.notesDarkText,
              side: const BorderSide(color: AppColors.directoryBorder),
              backgroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'Отмена',
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: isButtonDisabled ? null : _createAccrual,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
