import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderboardListTile extends StatelessWidget {
  const LeaderboardListTile({
    super.key,
    required this.username,
    required this.index,
    required this.score,
    this.color = Palette.neutralBeige,
  });

  final String username;
  final int index;
  final int score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: Row(
        children: [
          gap12,
          Text(
            index.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Palette.neutralBlack,
                ),
          ),
          gap8,
          SvgPicture.asset(
            AssetPaths.ecoAvatar,
            height: 40,
            width: 40,
          ),
          gap10,
          Text(
            username,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Palette.neutralBlack,
                ),
          ),
          const Spacer(),
          gap24,
          Text(
            score.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Palette.neutralBlack,
                ),
          ),
          gap4,
          SvgPicture.asset(
            AssetPaths.iconPoints,
            height: 24,
            width: 24,
          ),
          gap24,
        ],
      ),
    );
  }
}
