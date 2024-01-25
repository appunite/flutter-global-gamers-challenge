import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/finished_challenge_buttons.dart';
import 'package:endless_runner/challenges/common_widgets/score_container.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class ChallengeNoScoreScreen extends StatefulWidget {
  const ChallengeNoScoreScreen({
    super.key,
    required this.challengeType,
    required this.onSecondaryButtonPressed,
    required this.onPrimaryButtonPressed,
  });

  static const String routePath = '/challenge-no-score';

  final ChallengeType challengeType;
  final VoidCallback onSecondaryButtonPressed;
  final VoidCallback onPrimaryButtonPressed;

  @override
  State<ChallengeNoScoreScreen> createState() => _ChallengeNoScoreScreenState();
}

class _ChallengeNoScoreScreenState extends State<ChallengeNoScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.accentBackground,
      body: SingleChildScrollView(
        child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              gap24,
              const RibbonHeader(
                text: 'TIME\'S UP!',
                width: 450,
                ribbonImage: AssetPaths.ribbonRed,
              ),
              Text(
                'Even small actions can have a big impact on the environment.\nLet\'s try again and make a difference!',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              gap16,
              //TODO
              const ScoreContainer(
                score: 0,
                bestScore: 19,
                time: '00:15',
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
    );
  }
}
