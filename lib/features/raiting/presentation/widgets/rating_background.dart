import 'package:flutter/material.dart';

class RatingBackground extends StatelessWidget {
  final Widget child;

  const RatingBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white.withAlpha(0)],
                stops: const [0.0, 0.3],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              'assets/images/background_raiting.png',
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
