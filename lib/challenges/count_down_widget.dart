import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/style/overlay_widget.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    final challengeController = Provider.of<ChallengeController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      challengeController.addListener(() {
        if (challengeController.countDownVisible) {
          _controller.forward();
        }
      });

      _scaleAnimation = Tween<double>(begin: 3, end: -1).animate(_controller)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            challengeController.setCountDown(visible: false);
            challengeController.setTimer(shouldStart: true);
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    final challengeController = context.watch<ChallengeController>();

    return challengeController.countDownVisible
        ? Stack(
            alignment: Alignment.center,
            children: [
              widget.child,
              const OverlayWidget(),
              AnimatedBuilder(
                animation: _controller,
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
          )
        : widget.child;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
