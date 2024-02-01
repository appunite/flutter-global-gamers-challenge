import 'dart:math';

import 'package:endless_runner/audio/audio_controller.dart';
import 'package:endless_runner/audio/sounds.dart';
import 'package:endless_runner/challenges/ocean_shooter/components/explosion_component.dart';
import 'package:endless_runner/challenges/ocean_shooter/components/microplastic_enum.dart';
import 'package:endless_runner/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class EnemyComponent extends SpriteAnimationComponent with HasGameReference<OceanChallengeScreen>, CollisionCallbacks {
  static const speed = 150;
  static final Vector2 initialSize = Vector2.all(25);

  EnemyComponent({
    required this.audioController,
    required super.position,
  }) : super(
          size: initialSize,
          anchor: Anchor.center,
        );

  final AudioController audioController;

  @override
  Future<void> onLoad() async {
    var randomMicroplastic = MicroplasticTypeEnum.random();

    animation = await game.loadSpriteAnimation(
      randomMicroplastic.assetPath,
      SpriteAnimationData.sequenced(
        stepTime: 1,
        amount: 1,
        textureSize: Vector2.all(randomMicroplastic.size),
      ),
    );
    add(CircleHitbox(collisionType: CollisionType.passive));
    angle = Random().nextDouble() * pi;
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= speed * dt;
    if (x <= 0) {
      removeFromParent();
    }
  }

  void takeHit() {
    removeFromParent();

    game.add(ExplosionComponent(position: position));
    game.increaseScore();
    audioController.playSfx(SfxType.microplasticDestroyed);
  }
}
