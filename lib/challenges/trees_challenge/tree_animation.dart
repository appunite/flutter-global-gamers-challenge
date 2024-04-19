import 'package:better_world/challenges/trees_challenge/animals_animations.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TreeAnimation extends StatefulWidget {
  const TreeAnimation({
    super.key,
    required this.index,
    required this.score,
  });

  final int index;
  final int score;

  @override
  State<TreeAnimation> createState() => _TreeAnimationState();
}

class _TreeAnimationState extends State<TreeAnimation> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );

  static const int _minimalPlantedTreesCount = 20;

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.score >= _minimalPlantedTreesCount)
          if (widget.index case 8 || 26 || 41 || 60 || 78 || 95 || 120 || 132)
            const Align(
              alignment: Alignment.bottomLeft,
              child: DeerAnimation(),
            ),
        const SizedBox(
          height: 150,
          width: 200,
        ),
        Lottie.asset(
          AssetPaths.treeAnimation,
          fit: BoxFit.contain,
          width: 100,
          height: 100,
          controller: _animationController,
        ),
        if (widget.score >= _minimalPlantedTreesCount) ...[
          if (widget.index case 3 || 22 || 64 || 104) const RabbitAnimation(),
          if (widget.index case 13 || 37 || 88 || 115) const RabbitFlipLeftAnimation(),
          if (widget.index case 17 || 34 || 50 || 80 || 97 || 127)
            const Align(
              alignment: Alignment.bottomLeft,
              child: SquirrelAnimation(),
            ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
