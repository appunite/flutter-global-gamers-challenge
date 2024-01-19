import 'dart:math';

import 'package:endless_runner/challenges/ocean_shooter/components/explosion_component.dart';
import 'package:endless_runner/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class EnemyComponent extends SpriteAnimationComponent with HasGameReference<OceanChallengeScreen>, CollisionCallbacks {
  static const speed = 150;
  static final Vector2 initialSize = Vector2.all(25);

  EnemyComponent({required super.position}) : super(size: initialSize, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      AssetPaths.enemy,
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 4,
        textureSize: Vector2.all(16),
      ),
    );
    add(CircleHitbox(collisionType: CollisionType.passive));
    angle = pi / 2;
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
  }
}
