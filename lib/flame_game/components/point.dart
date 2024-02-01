import 'package:endless_runner/common/asset_paths.dart';

import '../endless_world.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// The [Point] components are the components that the [Player] should collect
/// to finish a level. The points are represented by Flame's mascot; Ember.
class Point extends SpriteComponent with HasGameReference, HasWorldReference<EndlessWorld> {
  static final Vector2 spriteSize = Vector2.all(100);
  final speed = 200;
  final _srcSize = Vector2(150, 150);
  final _srcPosition = Vector2(60, 40);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      AssetPaths.lampSmall,
      srcPosition: _srcPosition,
      srcSize: _srcSize,
    );

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    // We need to move the component to the left together with the speed that we
    // have set for the world plus the speed set for the point, so that it
    // is visually moving to the left in the world.
    // `dt` here stands for delta time and it is the time, in seconds, since the
    // last update ran. We need to multiply the speed by `dt` to make sure that
    // the speed of the obstacles are the same no matter the refresh rate/speed
    // of your device.
    position.x -= (world.speed + speed) * dt;

    // When the component is no longer visible on the screen anymore, we
    // remove it.
    // The position is defined from the upper left corner of the component (the
    // anchor) and the center of the world is in (0, 0), so when the components
    // position plus its size in X-axis is outside of minus half the world size
    // we know that it is no longer visible and it can be removed.
    if (position.x + size.x / 2 < -world.size.x / 2) {
      removeFromParent();
    }
  }
}
