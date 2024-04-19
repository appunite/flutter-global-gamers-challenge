import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/ocean_shooter/ocean_challenge_game.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/common/time_helper.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:provider/provider.dart';

class OceanShooterPointsCounter extends StatefulWidget {
  const OceanShooterPointsCounter({super.key});

  @override
  State<OceanShooterPointsCounter> createState() => _StateOceanShooterPointsCounter();
}

class _StateOceanShooterPointsCounter extends State<OceanShooterPointsCounter> {
  late ChallengeController _challengeController;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _challengeController = context.read<ChallengeController>();
    _challengeController.addListener(() {
      final challengeScore = _challengeController.score;
      if (challengeScore < _score) {
        print('Listener challengeScore < _score');
      }
      setState(() {
        _score = _challengeController.score;
      });
    });
  }

  @override
  void dispose() {
    _challengeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.neutralWhite,
        borderRadius: borderRadius32,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            AssetPaths.iconPoints,
            height: 24,
            width: 24,
          ),
          gap12,
          Container(
            constraints: const BoxConstraints(minWidth: 35),
            child: Text(
              _score.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Palette.neutralBlack,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class OceanShooterTimerWidget extends StatefulWidget {
  const OceanShooterTimerWidget({
    super.key,
    required this.game,
  });

  final OceanChallengeGame game;

  @override
  State<OceanShooterTimerWidget> createState() => _OceanShooterTimerWidgetState();
}

class _OceanShooterTimerWidgetState extends State<OceanShooterTimerWidget> {
  PausableTimer? _timer;
  int _timeInSeconds = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer ??= PausableTimer.periodic(
      const Duration(seconds: 1),
      () {
        setState(() {
          _timeInSeconds--;

          if (_timeInSeconds <= 0) {
            _goToSummaryScreen();
          }
        });
      },
    );
    _timer!.start();
  }

  Future<void> _goToSummaryScreen() async {
    await context.read<ChallengeController>().onChallengeFinished(
          challengeType: ChallengeType.ocean,
        );

    if (!mounted) return;
    NavigationHelper.navigateToChallengeResultScreen(
      context,
      context.read<ChallengeController>().challengeSummary!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.neutralWhite,
        borderRadius: borderRadius32,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AssetPaths.iconTimer,
            height: 24,
            width: 24,
          ),
          gap8,
          Container(
            constraints: const BoxConstraints(minWidth: 75),
            alignment: Alignment.topCenter,
            height: 26,
            child: Text(
              _timeInSeconds.formatTime(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: _timeInSeconds < 6 ? Palette.error : Palette.neutralBlack),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
