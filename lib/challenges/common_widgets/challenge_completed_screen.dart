import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/challenges/common_widgets/badge_dialog.dart';
import 'package:better_world/challenges/common_widgets/finished_challenge_buttons.dart';
import 'package:better_world/challenges/common_widgets/score_container.dart';
import 'package:better_world/challenges/trees_challenge/challenge_summary_entity.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/confetti_animation.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _showIntroDialog();
    context.read<AudioController>().playSfx(SfxType.challengeSuccessful);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _showIntroDialog() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBadgeDialog();
    });
  }

  void _showBadgeDialog() {
    final playerProgress = Provider.of<PlayerProgressController>(context, listen: false);
    final scoreBeforeUpdate = widget.challengeSummary.challengeType.getChallengeScore(playerProgress.challenges);

    if (scoreBeforeUpdate == null || scoreBeforeUpdate == 0) {
      NavigationHelper.show(
        context,
        BadgeDialog(
          challengeType: widget.challengeSummary.challengeType,
          playerProgress: playerProgress,
          score: widget.challengeSummary.score,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
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
                  gap12,
                  Text(
                    widget.challengeSummary.challengeType.completedText,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  gap16,
                  ScoreContainer(
                    score: widget.challengeSummary.score,
                    bestScore: widget.challengeSummary.bestScore,
                    timeInSeconds: widget.challengeSummary.time,
                  ),
                  gap88,
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
