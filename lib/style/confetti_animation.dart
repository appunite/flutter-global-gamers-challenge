import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiAnimation extends StatelessWidget {
  const ConfettiAnimation({
    super.key,
    required this.confettiController,
    this.child,
  });

  final ConfettiController confettiController;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      numberOfParticles: 50,
      confettiController: confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
      child: child,
    );
  }
}
