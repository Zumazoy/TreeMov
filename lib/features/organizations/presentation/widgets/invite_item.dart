import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class InviteItem extends StatelessWidget {
  final String organizationName;
  final String inviterName;
  final String inviterEmail;
  final String createdAt;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const InviteItem({
    super.key,
    required this.organizationName,
    required this.inviterName,
    required this.inviterEmail,
    required this.createdAt,
    required this.onAccept,
    required this.onDecline,
  });

  String _getFormattedDate() {
    final date = DateTime.parse(createdAt);
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Сегодня';
    if (difference == 1) return 'Вчера';
    if (difference < 7) return '$difference дн. назад';
    return '${date.day}.${date.month}.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.notesBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.directoryBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.plusButton.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mail,
                  size: 20,
                  color: AppColors.plusButton,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      organizationName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayFieldText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      inviterName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grayFieldText,
                      ),
                    ),
                    Text(
                      inviterEmail,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.directoryTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.directoryTextSecondary.withOpacity(
                          0.1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getFormattedDate(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.directoryTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: onDecline,
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Отклонить'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onAccept,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.plusButton,
                  foregroundColor: AppColors.white,
                ),
                child: const Text('Принять'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
