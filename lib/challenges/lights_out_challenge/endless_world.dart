import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/lights_out_challenge/components/lamp_row_creator.dart';
import 'package:better_world/challenges/lights_out_challenge/lights_out_challenge_screen.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

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
  Vector2 get size => (parent as FlameGame).size;

  /// Countdown timer
  Timer? timer;
  int timeInSeconds = 31;

  /// The gravity is defined in virtual pixels per second squared.
  /// These pixels are in relation to how big the [FixedResolutionViewport] is.
  final double gravity = 30;

  /// Where the ground is located in the world and things should stop falling.
  late final double groundLevel = (size.y / 2) - (size.y / 15);

  final lampRowCreator = LampRowCreator();

  @override
  Future<void> onLoad() async {
    player = LightsOutEco(
      challengeController: challengeController,
      position: Vector2(-size.x / 3 + 120, groundLevel - 900),
      addScore: addScore,
    );
    add(player);

    challengeController.addListener(() {
      if (challengeController.startChallengeTimer) {
        game.overlays.remove(LightsOutChallengeScreen.countDownKey);

        if (!game.world.contains(lampRowCreator)) {
          add(lampRowCreator);
          _setButtons();
        }

        timer ??= _setTimer();
      }
    });
  }

  Timer _setTimer() {
    return Timer(
      1,
      onTick: () {
        if (timeInSeconds <= 0) {
          challengeController.onChallengeFinished(challengeType: ChallengeType.lightsOut);
          game.pauseEngine();
          game.overlays.add(LightsOutChallengeScreen.winDialogKey);
        } else {
          timeInSeconds--;
          game.overlays.remove(LightsOutChallengeScreen.appBarKey);
          game.overlays.add(LightsOutChallengeScreen.appBarKey);
        }
      },
      repeat: true,
    );
  }

  @override
  void onRemove() {
    game.overlays.remove(LightsOutChallengeScreen.mapButtonKey);
    game.overlays.remove(LightsOutChallengeScreen.infoButtonKey);
    timer?.stop();
    challengeController.dispose();
  }

  void addScore() {
    if (timer?.isRunning() ?? false) {
      challengeController.addPoints(points: 1);
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump();
  }

  void _setButtons() {
    game.overlays.add(LightsOutChallengeScreen.mapButtonKey);
    game.overlays.add(LightsOutChallengeScreen.infoButtonKey);
  }
}
