import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/style/const_values.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScoreContainer extends StatelessWidget {
  const ScoreContainer({
    super.key,
    required this.score,
    required this.time,
    required this.bestScore,
  });

  final int score;
  final String time;
  final int bestScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      width: 320,
      height: 155,
      decoration: BoxDecoration(
        color: Palette.neutralWhite.withOpacity(.3),
        borderRadius: borderRadius24,
      ),
      child: Column(
        children: [
          _CurrentScoreRow(score: score),
          gap12,
          _TimeRow(time: time),
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
    required this.time,
  });

  final String time;

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
            time, //TODO: format time
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
