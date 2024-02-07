import 'package:endless_runner/audio/audio_controller.dart';
import 'package:endless_runner/audio/sounds.dart';
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
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late ChallengeController _challengeController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _challengeController = Provider.of<ChallengeController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _challengeController.addListener(_listener);

      _scaleAnimation = Tween<double>(begin: 3, end: -1).animate(_animationController)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _challengeController.setCountDown(visible: false);
            _challengeController.setTimer(shouldStart: true);
          }
        });
    });
  }

  void _listener() {
    if (_challengeController.countDownVisible) {
      _animationController.forward();
      context.read<AudioController>().playSfx(SfxType.countdown);
    }
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
                animation: _animationController,
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
    _challengeController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
