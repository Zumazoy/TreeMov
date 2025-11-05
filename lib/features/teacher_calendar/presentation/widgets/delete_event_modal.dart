import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class DeleteEventModal extends StatefulWidget {
  final VoidCallback? onDeletePressed;

  const DeleteEventModal({super.key, this.onDeletePressed});

  @override
  State<DeleteEventModal> createState() => _DeleteEventModalState();
}

class _DeleteEventModalState extends State<DeleteEventModal> {
  String _selectedOption = 'Только это событие';

  final List<String> _deleteOptions = [
    'Только это событие',
    'Это и будущие события',
    'Все события',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: 367,
      constraints: const BoxConstraints(minHeight: 180),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._deleteOptions.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            return Column(
              children: [
                SizedBox(
                  width: 327,
                  height: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          option,
                          style: const TextStyle(
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.2,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = option;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selectedOption == option
                                  ? Colors.black
                                  : AppColors.grayFieldText,
                              width: _selectedOption == option ? 3 : 2,
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (index < _deleteOptions.length - 1)
                  Container(
                    width: 327,
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF2F213E),
                        width: 1,
                      ),
                    ),
                  ),
              ],
            );
          }),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: const Color(0xFF1E40AF),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'ОТМЕНА',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                width: 1,
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF2F213E), width: 1),
                ),
              ),

              Expanded(
                child: SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onDeletePressed?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: const Color(0xFFBE2B29),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'УДАЛИТЬ',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
