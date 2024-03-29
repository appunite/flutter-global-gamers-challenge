import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/style/overlay_widget.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool _shouldPlayCountdownSFX = true;

  @override
  void initState() {
    super.initState();

    _scaleAnimation = Tween<double>(begin: 3, end: -1).animate(widget.animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.challengeController.setCountDown(visible: false);
          widget.challengeController.setTimer(shouldStart: true);
        }
      });

    widget.challengeController.addListener(() {
      if (widget.challengeController.countDownVisible) {
        widget.animationController.forward();
        if (_shouldPlayCountdownSFX) {
          context.read<AudioController>().playSfx(SfxType.countdown);
          _shouldPlayCountdownSFX = false;
        }
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
