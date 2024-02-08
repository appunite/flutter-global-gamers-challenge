import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PointsCounter extends StatelessWidget {
  const PointsCounter({
    super.key,
    required this.pointsCount,
  });

  final int pointsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.neutralWhite,
        borderRadius: borderRadius32,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            AssetPaths.iconPoints,
            height: 24,
            width: 24,
          ),
          gap12,
          Container(
            constraints: const BoxConstraints(minWidth: 35),
            child: Text(
              pointsCount.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Palette.neutralBlack,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
