import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/ocean_shooter/components/enemy_creator.dart';
import 'package:better_world/challenges/ocean_shooter/components/fire_boost_creator.dart';
import 'package:better_world/challenges/ocean_shooter/components/ocean_shooter_background.dart';
import 'package:better_world/challenges/ocean_shooter/components/player_component.dart';
import 'package:better_world/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class OceanChallengeGame extends FlameGame with PanDetector, HasCollisionDetection {
  OceanChallengeGame({
    required this.audioController,
    required this.challengeController,
  });

  late final PlayerComponent player;
  late final AudioController audioController;
  final ChallengeController challengeController;
  late int score = 0;

  bool _gameAlreadyStarted = false;

  Timer? countdownTimer;
  int timeInSeconds = 30;

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
