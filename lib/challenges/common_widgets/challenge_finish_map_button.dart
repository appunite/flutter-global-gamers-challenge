import 'package:better_world/common/map_button.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/leaderboard/introduction/leaderboard_introduction_dialog.dart';
import 'package:better_world/main_map/main_map_screen.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/const_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChallengeFinishMapButton extends StatelessWidget {
  const ChallengeFinishMapButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: displayAdditionalPadding ? const EdgeInsets.all(8) : EdgeInsets.zero,
      child: MapButton(
        onTap: () {
          final playerProgress = context.read<PlayerProgressController>();
          playerProgress.loadPlayerData();

          if (playerProgress.challenges.getPlayedChallengesCount() == 0) {
            NavigationHelper.show(
              context,
              const LeaderboardIntroductionDialog(shouldGoToLeaderBoardScreen: true),
            );
          } else {
            Future.delayed(const Duration(milliseconds: 900), () {
              context.go(MainMapScreen.routePath);
            });
          }
        },
      ),
    );
  }
}
