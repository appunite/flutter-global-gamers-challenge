import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/challenges/ocean_shooter/ocean_challenge_game.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class FireBoostComponent extends SpriteAnimationComponent
    with HasGameReference<OceanChallengeGame>, CollisionCallbacks {
  static const speed = 150;
  static final Vector2 initialSize = Vector2.all(180);

  FireBoostComponent({
    required this.audioController,
    required super.position,
  }) : super(
          size: initialSize,
          anchor: Anchor.center,
        );

  final AudioController audioController;

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      AssetPaths.fireBoost,
      SpriteAnimationData.sequenced(
        stepTime: 1,
        amount: 1,
        textureSize: Vector2.all(180),
      ),
    );
    add(CircleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= speed * dt;
    if (x <= 0) {
      removeFromParent();
    }
  }
}
