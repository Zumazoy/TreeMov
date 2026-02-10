import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

/// Виджет отображения загрузки
class CenteredLoadingWidget extends StatelessWidget {
  final Color? color;

  const CenteredLoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.teacherPrimary,
      ),
    );
  }
}

/// Виджет отображения ошибки
class CenteredErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const CenteredErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Произошла ошибка',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.grayFieldText,
                fontFamily: 'TT Norms',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontFamily: 'TT Norms',
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Повторить'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Виджет пустого состояния
class CenteredEmptyWidget extends StatelessWidget {
  final String message;

  const CenteredEmptyWidget({super.key, this.message = 'Нет данных'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: 'TT Norms',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
