import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/ocean_shooter/components/enemy_creator.dart';
import 'package:better_world/challenges/ocean_shooter/components/fire_boost_creator.dart';
import 'package:better_world/challenges/ocean_shooter/components/ocean_shooter_background.dart';
import 'package:better_world/challenges/ocean_shooter/components/player_component.dart';
import 'package:better_world/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:better_world/style/palette.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OceanChallengeGame extends FlameGame with PanDetector, HasCollisionDetection, KeyboardEvents, HasGameRef {
  OceanChallengeGame({
    required this.audioController,
    required this.challengeController,
  }) : super(
          camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
        );

  late final PlayerComponent player;
  late final AudioController audioController;
  final ChallengeController challengeController;
  Vector2 orientationVector = Vector2.zero();
  late int score = 0;

  bool _gameAlreadyStarted = false;

  @override
  Future<void> onLoad() async {
    addAll([
      OceanShooterBackground(),
      player = PlayerComponent(audioController: audioController),
    ]);

    overlays.add(OceanChallengeScreen.mapButtonKey);
    overlays.add(OceanChallengeScreen.infoButtonKey);
    overlays.add(OceanChallengeScreen.countDownKey);
    overlays.add(OceanChallengeScreen.introductionDialogKey);

    challengeController.addListener(() {
      if (challengeController.startChallengeTimer) {
        if (!_gameAlreadyStarted) {
          overlays.remove(OceanChallengeScreen.countDownKey);
          add(EnemyCreator(audioController: audioController));
          player.beginFire();
          _gameAlreadyStarted = true;
          overlays.add(OceanChallengeScreen.appBarKey);
        }
      }
    });
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.position += info.delta.global;
    _clampToWindowSize();
  }

  void _clampToWindowSize() {
    player.position.x = player.position.x.clamp(0, game.camera.viewport.size.x + player.size.x * 0.5);
    player.position.y = player.position.y.clamp(0, game.camera.viewport.size.y + player.size.y * 0.5);
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    orientationVector = Vector2.zero();
    final bool moveDiagonallyTopLeft =
        (keysPressed.contains(LogicalKeyboardKey.arrowLeft) && keysPressed.contains(LogicalKeyboardKey.arrowUp)) ||
            (keysPressed.contains(LogicalKeyboardKey.keyA) && keysPressed.contains(LogicalKeyboardKey.keyW));

    final bool moveDiagonallyTopRight =
        (keysPressed.contains(LogicalKeyboardKey.arrowRight) && keysPressed.contains(LogicalKeyboardKey.arrowUp)) ||
            (keysPressed.contains(LogicalKeyboardKey.keyD) && keysPressed.contains(LogicalKeyboardKey.keyW));

    final bool moveDiagonallyBottomLeft =
        (keysPressed.contains(LogicalKeyboardKey.arrowLeft) && keysPressed.contains(LogicalKeyboardKey.arrowDown)) ||
            (keysPressed.contains(LogicalKeyboardKey.keyA) && keysPressed.contains(LogicalKeyboardKey.keyS));

    final bool moveDiagonallyBottomRight =
        (keysPressed.contains(LogicalKeyboardKey.arrowRight) && keysPressed.contains(LogicalKeyboardKey.arrowDown)) ||
            (keysPressed.contains(LogicalKeyboardKey.keyD) && keysPressed.contains(LogicalKeyboardKey.keyS));

    if (moveDiagonallyTopLeft) {
      orientationVector.add(Vector2(-0.66, -0.66));
    } else if (moveDiagonallyTopRight) {
      orientationVector.add(Vector2(0.66, -0.66));
    } else if (moveDiagonallyBottomLeft) {
      orientationVector.add(Vector2(-0.66, 0.66));
    } else if (moveDiagonallyBottomRight) {
      orientationVector.add(Vector2(0.66, 0.66));
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) || keysPressed.contains(LogicalKeyboardKey.keyA)) {
      orientationVector.add(Vector2(-1, 0));
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) || keysPressed.contains(LogicalKeyboardKey.keyD)) {
      orientationVector.add(Vector2(1, 0));
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) || keysPressed.contains(LogicalKeyboardKey.keyW)) {
      orientationVector.add(Vector2(0, -1));
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) || keysPressed.contains(LogicalKeyboardKey.keyS)) {
      orientationVector.add(Vector2(0, 1));
    }

    return KeyEventResult.handled;
  }

  void showEndDialog() {
    overlays.add(OceanChallengeScreen.winDialogKey);
  }

  @override
  void update(double dt) {
    challengeController.setPoints(points: score);

    player.velocity = orientationVector * player.moveSpeed;
    player.position += player.velocity * dt;
    _clampToWindowSize();

    super.update(dt);
  }

  void increaseScore() {
    score++;

    if (score == 15) {
      add(FireBoostCreator(audioController: audioController));
    }
  }

  void decreaseScore() {
    if (score <= 1) {
      score = 0;
    } else {
      score--;
    }
  }

  @override
  Color backgroundColor() => Palette.oceanShooterBackgroud;
}
