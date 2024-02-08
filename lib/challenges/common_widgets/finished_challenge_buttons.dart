import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/common/navigation_helper.dart';
import 'package:endless_runner/leaderboard/introduction/leaderboard_introduction_dialog.dart';
import 'package:endless_runner/player_progress/entities/challenges_entity.dart';
import 'package:endless_runner/player_progress/player_progress_controller.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FinishedChallengeButtons extends StatelessWidget {
  const FinishedChallengeButtons({
    super.key,
    required this.challengeType,
  });

  final ChallengeType challengeType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MainButton.secondary(
          width: 170,
          text: 'Play Again',
          onPressed: (_) {
            context.go(challengeType.routePath);
          },
        ),
        gap12,
        MainButton(
          width: 160,
          text: 'Go to Map',
          onPressed: (_) {
            final playerProgress = Provider.of<PlayerProgressController>(context, listen: false);

            if (playerProgress.challenges.getPlayedChallengesCount() == 0) {
              NavigationHelper.show(
                context,
                const LeaderboardIntroductionDialog(shouldGoToLeaderBoardScreen: true),
              );
            } else {
              context.go('/');
            }
          },
        ),
      ],
    );
  }
}
