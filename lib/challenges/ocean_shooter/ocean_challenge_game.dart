import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/challenge_type_enum.dart';
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

  bool _gameAlreadyStarted = false;

  Timer? oceanTimer;
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
        print(oceanTimer?.isRunning());
        try {
          if (oceanTimer == null) {
            oceanTimer = _setTimer();
            oceanTimer!.start();
            print('set');
          } else {
            print('NOT Null');
          }
        } catch (e) {
          print('ERROR1: $e');
        }

        if (!_gameAlreadyStarted) {
          overlays.remove(OceanChallengeScreen.countDownKey);
          add(EnemyCreator(audioController: audioController));
          player.beginFire();
          _gameAlreadyStarted = true;
        }
      }
    });
  }

  Timer _setTimer() {
    return Timer(
      1,
      onTick: () {
        print('TYKAM!');
        if (timeInSeconds <= 0) {
          challengeController.onChallengeFinished(challengeType: ChallengeType.ocean);
          pauseEngine();
          overlays.add(OceanChallengeScreen.winDialogKey);
        } else {
          timeInSeconds--;
          overlays.remove(OceanChallengeScreen.appBarKey);
          overlays.add(OceanChallengeScreen.appBarKey);
        }
      },
      repeat: true,
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.position += info.delta.global;
  }

  void showEndDialog() {
    overlays.add(OceanChallengeScreen.winDialogKey);
  }

  void increaseScore() {
    challengeController.addPoints(points: 1);

    if (challengeController.score == 30) {
      add(FireBoostCreator(audioController: audioController));
    }
  }
}
