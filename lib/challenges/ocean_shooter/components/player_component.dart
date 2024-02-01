import 'package:endless_runner/audio/audio_controller.dart';
import 'package:endless_runner/audio/sounds.dart';
import 'package:endless_runner/challenges/ocean_shooter/components/bullet_component.dart';
import 'package:endless_runner/challenges/ocean_shooter/components/explosion_component.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PlayerComponent extends SpriteAnimationComponent with HasGameRef, CollisionCallbacks {
  late TimerComponent bulletCreator;

  PlayerComponent({required this.audioController})
      : super(
          size: Vector2(234 / 2, 142 / 2),
          position: Vector2(100, 500),
          anchor: Anchor.center,
        );

  late final AudioController audioController;

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
      AssetPaths.submarine,
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 1,
        textureSize: Vector2(234, 142),
      ),
    );

    position = Vector2(64, game.size.y / 2);
  }

  final _bulletAngles = [
    0.3,
    0.0,
    -0.3,
  ];

  void _createBullet() {
    game.addAll(
      _bulletAngles.map(
        (angle) => BulletComponent(
          position: position + Vector2(size.x / 2, 0),
          angle: angle,
        ),
      ),
    );
    audioController.playSfx(SfxType.shoot);
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
    //TODO(Kostrzewsky): Hanel game over screen
    print('GAME OVER');
  }
}
