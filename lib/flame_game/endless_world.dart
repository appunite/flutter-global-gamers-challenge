import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/flame_game/components/lamp_row_creator.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'lights_out_challenge_screen.dart';
import 'components/lights_out_eco.dart';

class EndlessWorld extends World with TapCallbacks, HasGameReference {
  EndlessWorld({
    required this.challengeController,
  });

  final ChallengeController challengeController;

  /// The speed is used for determining how fast the background should pass by
  /// and how fast the enemies and obstacles should move.
  late double speed = 600;
  late final LightsOutEco player;
  late final DateTime timeStarted;
  Vector2 get size => (parent as FlameGame).size;
  int levelCompletedIn = 0;

  /// The gravity is defined in virtual pixels per second squared.
  /// These pixels are in relation to how big the [FixedResolutionViewport] is.
  final double gravity = 30;

  /// Where the ground is located in the world and things should stop falling.
  late final double groundLevel = (size.y / 2) - (size.y / 15);

  @override
  Future<void> onLoad() async {
    timeStarted = DateTime.now();

    add(LampRowCreator());
    //TODOF change to Eco
    player = LightsOutEco(
      position: Vector2(-size.x / 3, groundLevel - 900),
      addScore: addScore,
    );
    add(player);

    challengeController.addListener(() async {
      //TODO
      if (challengeController.score >= 20) {
        challengeController.onChallengeFinished(
          challengeType: ChallengeType.city,
          timeInSec: DateTime.now().difference(timeStarted).inSeconds,
        );
        game.pauseEngine();
        game.overlays.add(LightsOutChallengeScreen.winDialogKey);
      }
    });
  }

  @override
  void onRemove() {
    //TODO change to map icon
    // game.overlays.remove(GameScreen.backButtonKey);
    challengeController.dispose();
  }

  void addScore({int amount = 1}) {
    challengeController.addPoints(points: amount);
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump();
  }
}
