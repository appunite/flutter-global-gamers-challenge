import 'dart:math';

import 'package:endless_runner/challenges/ocean_shooter/components/bullet_component.dart';
import 'package:endless_runner/challenges/ocean_shooter/components/enemy_component.dart';
import 'package:endless_runner/challenges/ocean_shooter/components/explosion_component.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PlayerComponent extends SpriteAnimationComponent with HasGameRef, CollisionCallbacks {
  late TimerComponent bulletCreator;

  PlayerComponent()
      : super(
          size: Vector2(50, 75),
          position: Vector2(100, 500),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
    add(
      bulletCreator = TimerComponent(
        period: 1,
        repeat: true,
        autoStart: true,
        onTick: _createBullet,
      ),
    );
    animation = await game.loadSpriteAnimation(
      AssetPaths.player,
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 4,
        textureSize: Vector2(32, 39),
      ),
    );

    position = Vector2(64, game.size.y / 2);
    angle = pi / 2;
  }

  final _bulletAngles = [0.5, 0.3, 0.0, -0.3, -0.5];

  void _createBullet() {
    game.addAll(
      _bulletAngles.map(
        (angle) => BulletComponent(
          position: position + Vector2(size.x / 2, 0),
          angle: angle,
        ),
      ),
    );
  }

  void beginFire() {
    bulletCreator.timer.start();
  }

  void stopFire() {
    bulletCreator.timer.pause();
  }

  void takeHit() {
    game.add(ExplosionComponent(position: position));
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is EnemyComponent) {
      other.takeHit();
    }
  }
}
