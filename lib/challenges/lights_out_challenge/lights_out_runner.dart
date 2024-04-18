import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/lights_out_challenge/components/lights_out_eco.dart';
import 'package:better_world/challenges/lights_out_challenge/lights_out_challenge_screen.dart';
import 'package:better_world/style/palette.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../audio/audio_controller.dart';
import 'components/background.dart';
import 'lights_out_world.dart';

///  - That it should have a [FixedResolutionViewport] with a size of 1600x720,
///  this means that even if you resize the window, the game itself will keep
///  the defined virtual resolution.
class LightsOutRunner extends FlameGame<LightsOutWorld> with HasCollisionDetection, KeyboardEvents {
  LightsOutRunner({
    required this.challengeController,
    required this.audioController,
  }) : super(
          world: LightsOutWorld(challengeController: challengeController),
          camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
        );

  final AudioController audioController;
  final ChallengeController challengeController;

  @override
  Future<void> onLoad() async {
    camera.backdrop.add(LightsOutChallenge(speed: world.speed, challengeController: challengeController));
    overlays.add(LightsOutChallengeScreen.countDownKey);
    overlays.add(LightsOutChallengeScreen.introductionDialogKey);
  }

  @override
  Color backgroundColor() => Palette.lightsOutBackground;

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
    final isArrowUp = keysPressed.contains(LogicalKeyboardKey.arrowUp);

    if (isSpace || isArrowUp) {
      world.children.whereType<LightsOutEco>().first.jump();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
