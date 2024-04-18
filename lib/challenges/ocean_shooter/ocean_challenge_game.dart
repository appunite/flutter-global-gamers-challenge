import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/ocean_shooter/components/enemy_creator.dart';
import 'package:better_world/challenges/ocean_shooter/components/fire_boost_creator.dart';
import 'package:better_world/challenges/ocean_shooter/components/ocean_shooter_background.dart';
import 'package:better_world/challenges/ocean_shooter/components/player_component.dart';
import 'package:better_world/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OceanChallengeGame extends FlameGame with PanDetector, HasCollisionDetection, KeyboardEvents {
  OceanChallengeGame({
    required this.audioController,
    required this.challengeController,
  });

  late final PlayerComponent player;
  late final AudioController audioController;
  final ChallengeController challengeController;
  late int score = 0;
  static const double _playerSpeed = 50;

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
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      player.position.x -= _playerSpeed;
      player.position.x = player.position.x.clamp(0, size.x - player.size.x);
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      player.position.x += _playerSpeed;
      player.position.x = player.position.x.clamp(0, size.x - player.size.x);
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      player.position.y -= _playerSpeed;
      player.position.y = player.position.y.clamp(0, size.y - player.size.y);
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      player.position.y += _playerSpeed;
      player.position.y = player.position.y.clamp(0, size.y - player.size.y);
    }

    return KeyEventResult.handled;
  }

  void showEndDialog() {
    overlays.add(OceanChallengeScreen.winDialogKey);
  }

  @override
  void update(double dt) {
    super.update(dt);
    challengeController.setPoints(points: score);
  }

  void increaseScore() {
    score++;

    if (score == 15) {
      add(FireBoostCreator(audioController: audioController));
    }
  }
}
