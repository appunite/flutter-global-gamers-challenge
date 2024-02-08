import 'package:better_world/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class OceanShooterBackground extends SpriteComponent with HasGameRef<OceanChallengeScreen> {
  OceanShooterBackground();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(AssetPaths.oceanShooterBackground);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
