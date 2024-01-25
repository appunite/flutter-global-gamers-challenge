import 'package:confetti/confetti.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/badge_container.dart';
import 'package:endless_runner/challenges/common_widgets/finished_challenge_buttons.dart';
import 'package:endless_runner/challenges/common_widgets/score_container.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/style/confetti_animation.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class ChallengeCompletedScreen extends StatefulWidget {
  const ChallengeCompletedScreen({
    super.key,
    required this.challengeType,
    required this.onSecondaryButtonPressed,
    required this.onPrimaryButtonPressed,
  });

  static const String routePath = '/challenge-completed';

  final ChallengeType challengeType;
  final VoidCallback onSecondaryButtonPressed;
  final VoidCallback onPrimaryButtonPressed;

  @override
  State<ChallengeCompletedScreen> createState() => _ChallengeCompletedScreenState();
}

class _ChallengeCompletedScreenState extends State<ChallengeCompletedScreen> {
  late final ConfettiController _confettiController = ConfettiController(
    duration: const Duration(seconds: 1),
  );

  // TODO: handle values from the player controller
  final _hasBadge = true;
  final _hasScore = false;

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Palette.accentBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  gap24,
                  const RibbonHeader(
                    text: 'CONGRATULATIONS',
                    width: 450,
                  ),
                  Text(
                    widget.challengeType.completedText,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  gap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_hasBadge) ...[
                        const BadgeContainer(
                          badgeName: 'TODO',
                          badgeImage: AssetPaths.iconMusic,
                        ),
                        gap12,
                      ],
                      if (_hasScore)
                        const ScoreContainer(
                          score: 9,
                          bestScore: 19,
                          time: '00:15',
                        ),
                    ],
                  ),
                  gap60,
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FinishedChallengeButtons(
            onSecondaryButtonPressed: widget.onSecondaryButtonPressed,
            onPrimaryButtonPressed: widget.onPrimaryButtonPressed,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiAnimation(
            confettiController: _confettiController,
          ),
        ),
      ],
    );
  }
}
