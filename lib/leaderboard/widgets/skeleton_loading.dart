import 'package:better_world/leaderboard/widgets/leaderboard_list_tile.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SkeletonLoader(
            items: 15,
            period: Duration(milliseconds: 1000),
            baseColor: Palette.accentLight,
            highlightColor: Palette.accentSkeleton,
            builder: Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: LeaderboardListTile(
                index: 0,
                username: '...',
                color: Palette.accentLight,
                score: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
