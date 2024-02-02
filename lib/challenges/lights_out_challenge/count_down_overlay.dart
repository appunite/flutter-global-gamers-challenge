import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/style/overlay_widget.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class CountDownFlameOverlay extends StatefulWidget {
  const CountDownFlameOverlay({
    super.key,
    required this.challengeController,
    required this.animationController,
  });

  final ChallengeController challengeController;
  final AnimationController animationController;

  @override
  State<CountDownFlameOverlay> createState() => _CountDownFlameOverlayState();
}

class _CountDownFlameOverlayState extends State<CountDownFlameOverlay> {
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleAnimation = Tween<double>(begin: 3, end: 0).animate(widget.animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.challengeController.setCountDown(visible: false);
          widget.challengeController.setTimer(shouldStart: true);
        }
      });

    widget.challengeController.addListener(() {
      if (widget.challengeController.countDownVisible) {
        widget.animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const OverlayWidget(),
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (_, __) {
            return Text(
              _scaleAnimation.value.ceil() <= 0 ? 'START' : _scaleAnimation.value.ceil().toString(),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Palette.neutralWhite,
                  ),
            );
          },
        ),
      ],
    );
  }
}
