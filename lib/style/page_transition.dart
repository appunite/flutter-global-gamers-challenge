import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' show sqrt, max;
import 'dart:ui' show lerpDouble;

CustomTransitionPage<T> buildPageTransition<T>({
  required Widget child,
  required Color color,
  String? name,
  Object? arguments,
  String? restorationId,
  LocalKey? key,
  Offset? offset,
}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return CircularRevealTransition.buildTransitions(
          context, Curves.easeInOut, Alignment.center, animation, secondaryAnimation, child, offset);
      // _PageReveal(
      //   animation: animation,
      //   color: color,
      //   child: child,
      // );
    },
    key: key,
    name: name,
    arguments: arguments,
    restorationId: restorationId,
    transitionDuration: const Duration(milliseconds: 700),
  );
}

class _PageReveal extends StatelessWidget {
  final Widget child;

  final Animation<double> animation;

  final Color color;

  final _slideTween = Tween(begin: const Offset(0, -1), end: Offset.zero);

  final _fadeTween = TweenSequence([
    TweenSequenceItem(tween: ConstantTween(0.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
  ]);

  _PageReveal({
    required this.child,
    required this.animation,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SlideTransition(
          position: _slideTween.animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeOutCubic,
            ),
          ),
          child: Container(
            color: color,
          ),
        ),
        FadeTransition(
          opacity: _fadeTween.animate(animation),
          child: child,
        ),
      ],
    );
  }
}

class CircularRevealTransition {
  static Widget buildTransitions(BuildContext context, Curve? curve, Alignment? alignment, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child, Offset? offset) {
    return ClipPath(
      clipper: CircularRevealClipper(
        fraction: animation.value,
        centerAlignment: Alignment.center,
        centerOffset: offset,
        minRadius: 0,
        maxRadius: 800,
      ),
      child: child,
    );
  }
}

class CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Alignment? centerAlignment;
  final Offset? centerOffset;
  final double? minRadius;
  final double? maxRadius;

  CircularRevealClipper({
    required this.fraction,
    this.centerAlignment,
    this.centerOffset,
    this.minRadius,
    this.maxRadius,
  });

  @override
  Path getClip(Size size) {
    final center = centerAlignment?.alongSize(size) ?? centerOffset ?? Offset(size.width / 2, size.height / 2);
    final minRadius = this.minRadius ?? 0;
    final maxRadius = this.maxRadius ?? calcMaxRadius(size, center);

    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: lerpDouble(minRadius, maxRadius, fraction)!,
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  static double calcMaxRadius(Size size, Offset center) {
    final w = max(center.dx, size.width - center.dx);
    final h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }
}
