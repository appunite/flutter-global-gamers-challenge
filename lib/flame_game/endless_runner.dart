import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../audio/audio_controller.dart';
import 'components/background.dart';
import 'endless_world.dart';

///  - That it should have a [FixedResolutionViewport] with a size of 1600x720,
///  this means that even if you resize the window, the game itself will keep
///  the defined virtual resolution.
class EndlessRunner extends FlameGame<EndlessWorld> with HasCollisionDetection {
  EndlessRunner({
    required ChallengeController challengeController,
    required this.audioController,
  }) : super(
          world: EndlessWorld(challengeController: challengeController),
          camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
        );

  final AudioController audioController;

  @override
  Future<void> onLoad() async {
    camera.backdrop.add(Background(speed: world.speed));

    // With the `TextPaint` we define what properties the text that we are going
    // to render will have, like font family, size and color in this instance.
    final textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontFamily: 'Press Start 2P',
      ),
    );

    const scoreText = 'Embers: 0 / 5';

    // The component that is responsible for rendering the text that contains
    // the current score.
    final scoreComponent = TextComponent(
      text: scoreText,
      position: Vector2.all(30),
      textRenderer: textRenderer,
    );

    camera.viewport.add(scoreComponent);

    // Here we add a listener to the notifier that is updated when the player
    // gets a new point, in the callback we update the text of the
    // `scoreComponent`.
    world.challengeController.addListener(() {
      scoreComponent.text = scoreText.replaceFirst('0', '${world.challengeController.score}');
    });
  }
}
