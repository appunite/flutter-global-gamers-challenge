import 'dart:math';

import 'package:better_world/challenges/ocean_shooter/components/enemy_component.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class BulletComponent extends SpriteAnimationComponent with HasGameRef, CollisionCallbacks {
  static const speed = 500.0;
  late final Vector2 velocity;
  final Vector2 deltaPosition = Vector2.zero();

  BulletComponent({
    required super.position,
    super.angle,
  }) : super(size: Vector2(10, 20));

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
    animation = await game.loadSpriteAnimation(
      AssetPaths.bullet,
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 4,
        textureSize: Vector2(8, 16),
      ),
    );
    velocity = Vector2(1, 0)
      ..rotate(angle)
      ..scale(speed);
    angle = pi / 2;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is EnemyComponent) {
      other.takeHit();
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    deltaPosition
      ..setFrom(velocity)
      ..scale(dt);
    position += deltaPosition;

    if (position.y < 0 || position.x > game.size.x || position.x + size.x < 0) {
      removeFromParent();
    }
  }
}
