import 'dart:ui';

import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class Background extends ParallaxComponent {
  Background({
    required this.speed,
    required this.challengeController,
  });

  final double speed;
  final ChallengeController challengeController;
  final layers = [
    ParallaxImageData(AssetPaths.lightsOutBackground),
  ];

  @override
  Future<void> onLoad() async {
    Vector2? velocity;

    challengeController.addListener(() async {
      if (challengeController.startChallengeTimer) {
        if (velocity == null) {
          velocity = Vector2(speed, 0);
          await _setParallax(layers, velocity!);
        }
      }
    });

    await _setParallax(layers, Vector2(0, 0));
  }

  Future<void> _setParallax(List<ParallaxImageData> layers, Vector2 velocity) async {
    parallax = await game.loadParallax(
      layers,
      baseVelocity: velocity,
      filterQuality: FilterQuality.none,
    );
  }
}
