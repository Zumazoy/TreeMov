import 'package:flutter/material.dart';
import '../../domain/entities/point_category_entity.dart';
import '../widgets/category_buttons.dart';
import '../widgets/student_header.dart';
import '../widgets/custom_action_form.dart';
import '../../data/mocks/mock_points_data.dart';
import '../../../../core/themes/app_colors.dart';

class ActionSelectionDialog extends StatefulWidget {
  final StudentWithPoints student;

  const ActionSelectionDialog({super.key, required this.student});

  @override
  State<ActionSelectionDialog> createState() => _ActionSelectionDialogState();
}

class _ActionSelectionDialogState extends State<ActionSelectionDialog> {
  PointCategory? _selectedCategory;
  PointAction? _selectedAction;
  List<PointAction> _currentActions = [];
  bool _showCustomAction = false;

  @override
  void initState() {
    super.initState();
    _updateActions();
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

  void _onConfirm() {
    if (_selectedAction != null) {
      Navigator.of(context).pop(_selectedAction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            onPressed: _selectedAction == null ? null : _onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedAction == null
                  ? AppColors.lightGrey
                  : const Color(0xFFDC2626),
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              _selectedAction == null
                  ? 'Выберите действие'
                  : 'Подтвердить ${_selectedAction!.points > 0 ? '+' : ''}${_selectedAction!.points}',
              style: const TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
