import 'package:better_world/common/asset_paths.dart';
import 'package:flame/components.dart';

class ExplosionComponent extends SpriteAnimationComponent with HasGameRef {
  ExplosionComponent({super.position})
      : super(
          size: Vector2.all(50),
          anchor: Anchor.center,
          removeOnFinish: true,
        );

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      AssetPaths.explosion,
      SpriteAnimationData.sequenced(
        stepTime: 0.1,
        amount: 6,
        textureSize: Vector2(124, 124),
        loop: false,
      ),
    );
  }
}
