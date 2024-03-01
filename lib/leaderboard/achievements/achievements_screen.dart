import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/common_widgets/badge_dialog.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/leaderboard/achievements/achievements_app_bar.dart';
import 'package:better_world/leaderboard/achievements/achievements_list_tile.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          gap16,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80) + const EdgeInsets.only(bottom: 50),
              child: Center(
                child: GridView.builder(
                  primary: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.7,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: 8,
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
                      case 6:
                        return const SizedBox();
                      case 7:
                        return const WorldHeroBadgeTile();

                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorldHeroBadgeTile extends StatelessWidget {
  const WorldHeroBadgeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProgress = context.watch<PlayerProgressController>();
    final shouldDisplayAchievement = playerProgress.challenges.getPlayedChallengesCount() == 6;

    return InkWell(
      onTap: () => shouldDisplayAchievement
          ? NavigationHelper.show(
              context,
              BadgeDialog.gameCompleted(),
            )
          : null,
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(90)),
              color: shouldDisplayAchievement ? null : Palette.neutralWhite.withOpacity(0.4),
              boxShadow: shouldDisplayAchievement
                  ? [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        spreadRadius: 1,
                        color: Palette.neutralBlack.withOpacity(0.2),
                      ),
                    ]
                  : null,
            ),
            child: shouldDisplayAchievement
                ? SvgPicture.asset(
                    gameCompletedBadgeAsset,
                  )
                : const SizedBox.shrink(),
          ),
          gap8,
          Container(
            width: shouldDisplayAchievement ? null : 100,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: shouldDisplayAchievement ? Palette.neutralWhite : Palette.neutralWhite.withOpacity(0.4),
            ),
            child: Text(
              shouldDisplayAchievement ? gameCompletedBadgeTitle.toUpperCase() : '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Palette.neutralBlack,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
