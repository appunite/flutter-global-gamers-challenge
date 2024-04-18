import 'package:better_world/audio/sounds.dart';
import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../jump_effect.dart';
import '../lights_out_runner.dart';
import '../lights_out_world.dart';
import 'lamp.dart';

/// The [LightsOutEco] is the component that the physical player of the game is
/// controlling.
class LightsOutEco extends SpriteAnimationGroupComponent<EcoLightsOutState>
    with CollisionCallbacks, HasWorldReference<LightsOutWorld>, HasGameReference<LightsOutRunner> {
  LightsOutEco({
    required this.addScore,
    required this.challengeController,
    super.position,
  }) : super(size: Vector2.all(200), anchor: Anchor.center, priority: 1);

  final void Function() addScore;
  final ChallengeController challengeController;

  // The current velocity that the player has that comes from being affected by
  // the gravity. Defined in virtual pixels/s².
  double _gravityVelocity = 0;

  // The maximum length that the player can jump. Defined in virtual pixels.
  final double _jumpLength = 380;
  bool _canDoubleJump = true;

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
    // This defines the different animation states that Eco can be in.
    animations = {
      EcoLightsOutState.running: await game.loadSpriteAnimation(
        AssetPaths.ecoRunning,
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2.all(1923),
          stepTime: 0.15,
        ),
      ),
      EcoLightsOutState.jumping: SpriteAnimation.spriteList(
        [await game.loadSprite(AssetPaths.ecoJumping)],
        stepTime: double.infinity,
      ),
      EcoLightsOutState.falling: SpriteAnimation.spriteList(
        [await game.loadSprite(AssetPaths.ecoFalling)],
        stepTime: double.infinity,
      ),
    };
    // The starting state will be that the player is running.
    current = EcoLightsOutState.idle;
    _lastPosition.setFrom(position);

    // When adding a CircleHitbox without any arguments it automatically
    // fills up the size of the component as much as it can without overflowing
    // it.
    add(CircleHitbox());

    challengeController.addListener(() {
      if (challengeController.startChallengeTimer) {
        current = EcoLightsOutState.running;
      }
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    game.world.timer?.update(dt);

    // When we are in the air the gravity should affect our position and pull
    // us closer to the ground.
    if (inAir) {
      _gravityVelocity += world.gravity * dt;
      position.y += _gravityVelocity;
      if (isFalling) {
        current = EcoLightsOutState.falling;
      }
    }

    final belowGround = position.y + size.y / 2 > world.groundLevel;
    // If the player's new position would overshoot the ground level after
    // updating its position we need to move the player up to the ground level
    // again.
    if (belowGround) {
      position.y = world.groundLevel - size.y / 2;
      _gravityVelocity = 0;
      current = EcoLightsOutState.running;
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
      addScore();
      //_gravityVelocity += 10;
      position.y += _gravityVelocity;
      current = EcoLightsOutState.falling;
      game.audioController.playSfx(SfxType.score);
      other.lampTurnedOff();
    }
  }

  void jump() {
    current = EcoLightsOutState.jumping;

    late JumpEffect jumpEffect;
    if (inAir) {
      if (_canDoubleJump) {
        jumpEffect = JumpEffect(Vector2(0, -_jumpLength)..scaleTo(_jumpLength));
        _canDoubleJump = false;
      }
    } else {
      _canDoubleJump = true;
      jumpEffect = JumpEffect(Vector2(0, -_jumpLength / 2 - 100));
    }
    add(jumpEffect);

    if (!inAir) {
      game.audioController.playSfx(SfxType.jump);
    }
  }
}

enum EcoLightsOutState {
  idle,
  running,
  jumping,
  falling,
}
