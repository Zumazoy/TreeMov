import 'package:flutter/material.dart';
import 'package:treemov/core/themes/app_colors.dart';

class MemberItem extends StatelessWidget {
  final String name;
  final String role;
  final String? email;
  final Color avatarColor;
  final VoidCallback? onTap;
  final bool isCurrentUser; // Добавляем параметр

  const MemberItem({
    super.key,
    required this.name,
    required this.role,
    this.email,
    required this.avatarColor,
    this.onTap,
    this.isCurrentUser = false, // по умолчанию false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.directoryBorder),
            ),
            child: Row(
              children: [
                // Аватар с инициалами
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: avatarColor.withAlpha(25),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : '?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: avatarColor,
                          ),
                        ),
                      ),
                    ),
                    // Индикатор "Это вы"
                    if (isCurrentUser)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.plusButton,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              size: 8,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),

                // Информация о пользователе
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grayFieldText,
                              ),
                            ),
                          ),
                          if (isCurrentUser)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.plusButton.withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Это вы',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: AppColors.plusButton,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (email != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          email!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.directoryTextSecondary,
                          ),
                        ),
                      ],
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: avatarColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          role,
                          style: TextStyle(
                            fontSize: 10,
                            color: avatarColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
