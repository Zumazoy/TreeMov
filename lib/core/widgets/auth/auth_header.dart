import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class AuthHeader extends StatefulWidget {
  const AuthHeader({super.key});

  @override
  State<AuthHeader> createState() => _AuthHeaderState();
}

class _AuthHeaderState extends State<AuthHeader> with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    if (_isKeyboardVisible != bottomInset > 100) {
      setState(() {
        _isKeyboardVisible = bottomInset > 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isKeyboardVisible) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 140,
      left: 171,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/white_default_logo.png',
            width: 60,
            height: 58,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 2),
          const Text(
            'TreeMov',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppColors.white,
              fontFamily: 'TT Norms',
            ),
          ),
        ],
      ),
    );
  }
}
