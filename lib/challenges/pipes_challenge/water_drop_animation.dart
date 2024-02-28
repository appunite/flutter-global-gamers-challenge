import 'package:better_world/challenges/pipes_challenge/pipes_controller.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class WaterDropAnimation extends StatefulWidget {
  const WaterDropAnimation({
    super.key,
  });

  @override
  State<WaterDropAnimation> createState() => _WaterDropAnimationState();
}

class _WaterDropAnimationState extends State<WaterDropAnimation> {
  bool _isAnimationVisible = false;
  late PipesController _pipesController;

  @override
  void initState() {
    super.initState();
    _pipesController = context.read<PipesController>();

    _pipesController.addListener(() {
      if (_pipesController.challengeCompleted) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _isAnimationVisible = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -8,
      right: 156,
      child: Visibility(
        visible: _isAnimationVisible,
        child: const SizedBox(
          height: 150,
          width: 30,
          child: RiveAnimation.asset(
            AssetPaths.waterDrop,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pipesController.dispose();
    super.dispose();
  }
}
