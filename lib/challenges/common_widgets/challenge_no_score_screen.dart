import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/challenges/common_widgets/challenge_finish_map_button.dart';
import 'package:better_world/challenges/common_widgets/finished_challenge_buttons.dart';
import 'package:better_world/challenges/common_widgets/score_container.dart';
import 'package:better_world/challenges/trees_challenge/challenge_summary_entity.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChallengeNoScoreScreen extends StatefulWidget {
  const ChallengeNoScoreScreen({
    super.key,
    required this.challengeSummary,
  });

  static const String routePath = '/challenge-no-score';

  final ChallengeSummaryEntity challengeSummary;

  @override
  State<ChallengeNoScoreScreen> createState() => _ChallengeNoScoreScreenState();
}

class _ChallengeNoScoreScreenState extends State<ChallengeNoScoreScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AudioController>().playSfx(SfxType.challengeUnsuccessful);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.accentBackground,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      gap24,
                      const RibbonHeader(
                        text: 'TIME\'S UP!',
                        width: 450,
                        ribbonImage: AssetPaths.ribbonRed,
                      ),
                      gap12,
                      Text(
                        'Even small actions can have a big impact on the environment. Let\'s try again and make a difference!',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      gap16,
                      ScoreContainer(
                        score: widget.challengeSummary.score,
                        bestScore: widget.challengeSummary.bestScore,
                        timeInSeconds: widget.challengeSummary.time,
                      ),
                      gap60,
                    ],
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: ChallengeFinishMapButton(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FinishedChallengeButtons(
        challengeType: widget.challengeSummary.challengeType,
      ),
    );
  }
}
