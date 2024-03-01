import 'package:better_world/leaderboard/widgets/leaderboard_list_tile.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      shimmerGradient: const LinearGradient(
        colors: [
          Palette.accentLight,
          Palette.accentSkeleton,
          Palette.accentLight,
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      child: SkeletonListView(
        padding: EdgeInsets.zero,
        item: const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: LeaderboardListTile(
            index: 0,
            username: '...',
            color: Palette.accentLight,
            score: 0,
          ),
        ),
      ),
    );
  }
}
