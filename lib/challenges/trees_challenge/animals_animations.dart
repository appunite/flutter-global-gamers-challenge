import 'package:better_world/common/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class RabbitAnimation extends StatelessWidget {
  const RabbitAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      AssetPaths.rabbitAnimation,
      height: 25,
      width: 25,
    );
  }
}

class RabbitFlipLeftAnimation extends StatelessWidget {
  const RabbitFlipLeftAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: LottieBuilder.asset(
        AssetPaths.rabbitAnimation,
        height: 25,
        width: 25,
      ),
    );
  }
}

class DeerAnimation extends StatelessWidget {
  const DeerAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      AssetPaths.deerAnimation,
      alignment: Alignment.bottomLeft,
      height: 200,
      width: 200,
    );
  }
}

class SquirrelAnimation extends StatelessWidget {
  const SquirrelAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      AssetPaths.squirrelAnimation,
      height: 15,
    );
  }
}
