import 'package:better_world/common/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TreeAnimation extends StatefulWidget {
  const TreeAnimation({
    super.key,
  });

  @override
  State<TreeAnimation> createState() => _TreeAnimationState();
}

class _TreeAnimationState extends State<TreeAnimation> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AssetPaths.treeAnimation,
      fit: BoxFit.contain,
      width: 100,
      height: 100,
      controller: _animationController,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
