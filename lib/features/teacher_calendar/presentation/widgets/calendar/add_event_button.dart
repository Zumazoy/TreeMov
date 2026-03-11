import 'package:flutter/material.dart';

class AddEventButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddEventButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.5),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            'Добавить событие',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'TT Norms',
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
