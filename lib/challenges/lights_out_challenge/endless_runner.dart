import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/lights_out_challenge/lights_out_challenge_screen.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import '../../audio/audio_controller.dart';
import 'components/background.dart';
import 'endless_world.dart';

///  - That it should have a [FixedResolutionViewport] with a size of 1600x720,
///  this means that even if you resize the window, the game itself will keep
///  the defined virtual resolution.
class EndlessRunner extends FlameGame<EndlessWorld> with HasCollisionDetection {
  EndlessRunner({
    required this.challengeController,
    required this.audioController,
  }) : super(
          world: EndlessWorld(challengeController: challengeController),
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
}
