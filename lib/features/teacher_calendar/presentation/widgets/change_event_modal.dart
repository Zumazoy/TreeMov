import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class ChangeEventModal extends StatefulWidget {
  final Function(String)? onOptionSelected;

  const ChangeEventModal({super.key, this.onOptionSelected});

  @override
  State<ChangeEventModal> createState() => _ChangeEventModalState();
}

class _ChangeEventModalState extends State<ChangeEventModal> {
  final List<String> editOptions = [
    'Только это событие',
    'Это и будущие события',
    'Все события',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: 367,
      constraints: const BoxConstraints(minHeight: 120),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...editOptions.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onOptionSelected?.call(option);
                  },
                  child: SizedBox(
                    width: 327,
                    height: 24,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        option,
                        style: const TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                if (index < editOptions.length - 1)
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
        ],
      ),
    );
  }
}
