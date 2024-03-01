import 'package:better_world/challenges/common_widgets/badge_dialog.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
