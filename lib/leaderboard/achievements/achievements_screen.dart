import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/leaderboard/achievements/achievements_app_bar.dart';
import 'package:better_world/leaderboard/achievements/achievements_list_tile.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  static const String routePath = '/achievements';

  @override
  Widget build(BuildContext context) {
    final playerProgress = context.watch<PlayerProgressController>();

    return Scaffold(
      backgroundColor: Palette.accent,
      body: Column(
        children: [
          gap16,
          const AchievementsAppBar(),
          gap32,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: GridView.builder(
                primary: true,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 0,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return AchievementListTile(
                        challengeType: ChallengeType.solarPanel,
                        playerProgress: playerProgress,
                      );
                    case 1:
                      return AchievementListTile(
                        challengeType: ChallengeType.lightsOut,
                        playerProgress: playerProgress,
                      );
                    case 2:
                      return AchievementListTile(
                        challengeType: ChallengeType.trees,
                        playerProgress: playerProgress,
                      );
                    case 3:
                      return AchievementListTile(
                        challengeType: ChallengeType.ocean,
                        playerProgress: playerProgress,
                      );
                    case 4:
                      return AchievementListTile(
                        challengeType: ChallengeType.pipelines,
                        playerProgress: playerProgress,
                      );
                    case 5:
                      return AchievementListTile(
                        challengeType: ChallengeType.recycling,
                        playerProgress: playerProgress,
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
