import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/challenges/ocean_shooter/components/bullet_component.dart';
import 'package:better_world/challenges/ocean_shooter/components/enemy_component.dart';
import 'package:better_world/challenges/ocean_shooter/components/explosion_component.dart';
import 'package:better_world/challenges/ocean_shooter/components/fire_boost_component.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PlayerComponent extends SpriteAnimationComponent with HasGameRef, CollisionCallbacks {
  PlayerComponent({required this.audioController})
      : super(
          size: Vector2(117, 71),
          position: Vector2(100, 500),
          anchor: Anchor.center,
        );

  late TimerComponent bulletCreator;
  late final AudioController audioController;
  late final List<double> _initialBulletAngles = [0];

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
    animation = await game.loadSpriteAnimation(
      AssetPaths.submarine,
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 1,
        textureSize: Vector2(234, 142),
      ),
    );

    position = Vector2(64, game.size.y / 2);
  }

  void _createBullet(List<double> bulletAngles) {
    game.addAll(
      bulletAngles.map(
        (angle) => BulletComponent(
          position: position + Vector2(size.x / 2, 0),
          angle: angle,
        ),
      ),
    );
    audioController.playSfx(SfxType.shoot);
  }

  void beginFire() {
    add(
      bulletCreator = TimerComponent(
        period: 1,
        repeat: true,
        autoStart: true,
        onTick: () => _createBullet(_initialBulletAngles),
      ),
    );
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
      game.add(ExplosionComponent(position: position));
      other.removeFromParent();
    } else if (other is FireBoostComponent) {
      remove(bulletCreator);
      add(
        bulletCreator = TimerComponent(
          period: 1,
          repeat: true,
          autoStart: true,
          onTick: () => _createBullet([-0.5, -0.3, 0, 0.3, 0.5]),
        ),
      );
      other.removeFromParent();
    }
  }
}
