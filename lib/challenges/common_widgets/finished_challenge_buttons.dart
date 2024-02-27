import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/leaderboard/introduction/leaderboard_introduction_dialog.dart';
import 'package:better_world/main_menu/main_map_screen.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainButton.secondary(
            width: 170,
            text: 'Play Again',
            onPressed: (_) {
              final playerProgress = context.read<PlayerProgressController>();
              playerProgress.loadPlayerData();
              context.go(challengeType.routePath);
            },
          ),
          gap12,
          MainButton(
            width: 160,
            text: 'Go to Map',
            onPressed: (_) {
              final playerProgress = context.read<PlayerProgressController>();
              playerProgress.loadPlayerData();

              if (playerProgress.challenges.getPlayedChallengesCount() == 0) {
                NavigationHelper.show(
                  context,
                  const LeaderboardIntroductionDialog(shouldGoToLeaderBoardScreen: true),
                );
              } else {
                context.go(MainMapScreen.routePath);
              }
            },
          ),
        ],
      ),
    );
  }
}
