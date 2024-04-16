import 'package:better_world/challenges/ocean_shooter/ocean_challenge_game.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class OceanShooterBackground extends SpriteComponent with HasGameRef<OceanChallengeGame> {
  OceanShooterBackground();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(AssetPaths.oceanShooterBackground);
    size = gameRef.camera.viewport.size;
    sprite = Sprite(background);
  }
}
