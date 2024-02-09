import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/time_helper.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScoreContainer extends StatelessWidget {
  const ScoreContainer({
    super.key,
    required this.score,
    this.timeInSeconds,
    required this.bestScore,
  });

  final int score;
  final int? timeInSeconds;
  final int bestScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(12),
      width: 320,
      decoration: BoxDecoration(
        color: Palette.neutralWhite.withOpacity(.3),
        borderRadius: borderRadius24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CurrentScoreRow(score: score),
          if (timeInSeconds != null) ...[
            gap12,
            _TimeRow(timeInSeconds: timeInSeconds!),
          ],
          gap16,
          _BestScoreRow(bestScore: bestScore, context: context),
        ],
      ),
    );
  }
}

class _CurrentScoreRow extends StatelessWidget {
  const _CurrentScoreRow({
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          SvgPicture.asset(
            AssetPaths.iconPoints,
            height: 24,
            width: 24,
          ),
          gap8,
          Text(
            'SCORE',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const Spacer(),
          Text(
            score.toString(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Palette.neutralBlack,
                ),
          ),
        ],
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({
    required this.timeInSeconds,
  });

  final int timeInSeconds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          SvgPicture.asset(
            AssetPaths.iconTimer,
            height: 24,
            width: 24,
          ),
          gap8,
          Text(
            'TIME',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const Spacer(),
          Text(
            timeInSeconds.formatTime(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Palette.neutralBlack,
                ),
          ),
        ],
      ),
    );
  }
}

class _BestScoreRow extends StatelessWidget {
  const _BestScoreRow({
    required this.bestScore,
    required this.context,
  });

  final int bestScore;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.neutralWhite,
        borderRadius: borderRadius16,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: Row(
        children: [
          Text(
            'YOUR BEST SCORE',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const Spacer(),
          SvgPicture.asset(
            AssetPaths.iconPoints,
            height: 24,
            width: 24,
          ),
          gap8,
          Text(
            bestScore.toString(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Palette.neutralBlack,
                ),
          ),
        ],
      ),
    );
  }
}
