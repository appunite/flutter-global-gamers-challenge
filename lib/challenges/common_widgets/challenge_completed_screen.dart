import 'package:confetti/confetti.dart';
import 'package:endless_runner/challenges/common_widgets/finished_challenge_buttons.dart';
import 'package:endless_runner/challenges/common_widgets/score_container.dart';
import 'package:endless_runner/challenges/trees_challenge/challenge_summary_entity.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/common/time_helper.dart';
import 'package:endless_runner/style/confetti_animation.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class ChallengeCompletedScreen extends StatefulWidget {
  const ChallengeCompletedScreen({
    super.key,
    required this.challengeSummary,
  });

  static const String routePath = '/challenge-completed';

  final ChallengeSummaryEntity challengeSummary;

  @override
  State<ChallengeCompletedScreen> createState() => _ChallengeCompletedScreenState();
}

class _ChallengeCompletedScreenState extends State<ChallengeCompletedScreen> {
  late final ConfettiController _confettiController = ConfettiController(
    duration: const Duration(seconds: 1),
  );

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  gap24,
                  const RibbonHeader(
                    text: 'CONGRATULATIONS',
                    width: 450,
                  ),
                  Text(
                    widget.challengeSummary.challengeType.completedText,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  gap16,
                  ScoreContainer(
                    score: widget.challengeSummary.score,
                    bestScore: widget.challengeSummary.bestScore,
                    time: widget.challengeSummary.time.formatTime(),
                  ),
                  gap60,
                  gapWidthMax,
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FinishedChallengeButtons(
            challengeType: widget.challengeSummary.challengeType,
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
