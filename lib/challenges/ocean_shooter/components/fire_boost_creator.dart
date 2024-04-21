import 'dart:math';

import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/challenges/ocean_shooter/components/enemy_component.dart';
import 'package:better_world/challenges/ocean_shooter/components/fire_boost_component.dart';
import 'package:flame/components.dart';

class FireBoostCreator extends TimerComponent with HasGameRef {
  final Random random = Random();
  final _halfHeight = EnemyComponent.initialSize.y / 2;

  FireBoostCreator({
    required this.audioController,
  }) : super(period: 1, repeat: false);

  final AudioController audioController;

  @override
  void onTick() {
    game.add(
      FireBoostComponent(
        audioController: audioController,
        position: Vector2(
          game.size.x,
          _halfHeight + (game.camera.viewport.size.y - _halfHeight) * random.nextDouble(),
        ),
      ),
    );
  }
}
