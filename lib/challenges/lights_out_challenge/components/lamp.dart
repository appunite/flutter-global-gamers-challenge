import 'dart:math';

import 'package:endless_runner/common/asset_paths.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import '../endless_world.dart';

class Lamp extends SpriteComponent with HasWorldReference<EndlessWorld> {
  Lamp.small({required double xPosition})
      : _srcSize = Vector2(64, 262),
        _srcPosition = Vector2.zero(),
        super(
          size: Vector2(100, 400),
          anchor: Anchor.bottomLeft,
          position: Vector2(xPosition, -180),
        );

  Lamp.medium({required double xPosition})
      : _srcSize = Vector2(64, 262),
        _srcPosition = Vector2.zero(),
        super(
          size: Vector2(100, 400),
          anchor: Anchor.bottomLeft,
          position: Vector2(xPosition, -100),
        );

  Lamp.long({required double xPosition})
      : _srcSize = Vector2(64, 262),
        _srcPosition = Vector2.zero(),
        super(
          size: Vector2(100, 400),
          anchor: Anchor.bottomLeft,
          position: Vector2(xPosition, -30),
        );

  /// Generates a random obstacle of type [LampType].
  factory Lamp.random({
    required double xPosition,
    Random? random,
  }) {
    const values = [LampType.small, LampType.medium, LampType.long];
    final lampType = values.random(random);
    switch (lampType) {
      case LampType.small:
        return Lamp.small(xPosition: xPosition);
      case LampType.medium:
        return Lamp.medium(xPosition: xPosition);
      case LampType.long:
        return Lamp.long(xPosition: xPosition);
    }
  }

  final Vector2? _srcSize;
  final Vector2? _srcPosition;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(
      AssetPaths.lamp,
      srcSize: _srcSize,
      srcPosition: _srcPosition,
    );

    add(RectangleHitbox());
  }

  Future<void> lampTurnedOff() async {
    sprite = await Sprite.load(
      AssetPaths.lampOff,
      srcSize: _srcSize,
      srcPosition: _srcPosition,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Moves the component to the left together with the speed that
    // is set for the world.

    position.x -= world.speed * dt;

    // When the component is no longer visible on the screen anymore,
    // remove it.
    if (position.x + size.x < -world.size.x / 2) {
      removeFromParent();
    }
  }
}

enum LampType {
  small,
  medium,
  long,
}
