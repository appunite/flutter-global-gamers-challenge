import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../audio/sounds.dart';
import '../endless_runner.dart';
import '../endless_world.dart';
import '../effects/jump_effect.dart';
import 'lamp_point.dart';

/// The [LightsOutEco] is the component that the physical player of the game is
/// controlling.
class LightsOutEco extends SpriteAnimationGroupComponent<PlayerState>
    with CollisionCallbacks, HasWorldReference<EndlessWorld>, HasGameReference<EndlessRunner> {
  LightsOutEco({
    required this.addScore,
    super.position,
  }) : super(size: Vector2.all(150), anchor: Anchor.center, priority: 1);

  final void Function({int amount}) addScore;

  // The current velocity that the player has that comes from being affected by
  // the gravity. Defined in virtual pixels/s².
  double _gravityVelocity = 0;

  // The maximum length that the player can jump. Defined in virtual pixels.
  final double _jumpLength = 400;

  // Whether the player is currently in the air, this can be used to restrict
  // movement for example.
  bool get inAir => (position.y + size.y / 2) < world.groundLevel;

  // Used to store the last position of the player, so that we later can
  // determine which direction that the player is moving.
  final Vector2 _lastPosition = Vector2.zero();

  // When the player has velocity pointing downwards it is counted as falling,
  // this is used to set the correct animation for the player.
  bool get isFalling => _lastPosition.y < position.y;

  @override
  Future<void> onLoad() async {
    // This defines the different animation states that the player can be in.
    animations = {
      PlayerState.running: await game.loadSpriteAnimation(
        'dash/dash_running.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2.all(16),
          stepTime: 0.15,
        ),
      ),
      PlayerState.jumping: SpriteAnimation.spriteList(
        [await game.loadSprite('dash/dash_jumping.png')],
        stepTime: double.infinity,
      ),
      PlayerState.falling: SpriteAnimation.spriteList(
        [await game.loadSprite('dash/dash_falling.png')],
        stepTime: double.infinity,
      ),
    };
    // The starting state will be that the player is running.
    current = PlayerState.running;
    _lastPosition.setFrom(position);

    // When adding a CircleHitbox without any arguments it automatically
    // fills up the size of the component as much as it can without overflowing
    // it.
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    // When we are in the air the gravity should affect our position and pull
    // us closer to the ground.
    if (inAir) {
      _gravityVelocity += world.gravity * dt;
      position.y += _gravityVelocity;
      if (isFalling) {
        current = PlayerState.falling;
      }
    }

    final belowGround = position.y + size.y / 2 > world.groundLevel;
    // If the player's new position would overshoot the ground level after
    // updating its position we need to move the player up to the ground level
    // again.
    if (belowGround) {
      position.y = world.groundLevel - size.y / 2;
      _gravityVelocity = 0;
      current = PlayerState.running;
    }

    _lastPosition.setFrom(position);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Lamp) {
      game.audioController.playSfx(SfxType.score);
      //TODO change asset?
      other.setColor(Colors.white);
      addScore();
    }
  }

  void jump() {
    current = PlayerState.jumping;

    late JumpEffect jumpEffect;
    if (inAir) {
      jumpEffect = JumpEffect(Vector2(0, -_jumpLength)..scaleTo(_jumpLength));
    } else {
      jumpEffect = JumpEffect(Vector2(0, -_jumpLength / 2 - 100));
    }
    add(jumpEffect);

    if (!inAir) {
      game.audioController.playSfx(SfxType.jump);
    }
  }
}

enum PlayerState {
  running,
  jumping,
  falling,
}
