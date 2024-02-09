import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/challenges/ocean_shooter/components/enemy_creator.dart';
import 'package:better_world/challenges/ocean_shooter/components/fire_boost_creator.dart';
import 'package:better_world/challenges/ocean_shooter/components/ocean_shooter_background.dart';
import 'package:better_world/challenges/ocean_shooter/components/player_component.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class OceanChallengeScreen extends FlameGame with PanDetector, HasCollisionDetection {
  static const String routePath = '/ocean-shooter-challenge';

  OceanChallengeScreen({
    required this.audioController,
  });

  late final PlayerComponent player;
  late final TextComponent componentCounter;
  late final TextComponent scoreText;
  late final AudioController audioController;
  late int _score = 0;

  @override
  Future<void> onLoad() async {
    addAll([
      OceanShooterBackground(),
      player = PlayerComponent(audioController: audioController),
      FpsTextComponent(
        position: size - Vector2(0, 50),
        anchor: Anchor.bottomRight,
      ),
      scoreText = TextComponent(
        position: size - Vector2(0, 25),
        anchor: Anchor.bottomRight,
        priority: 1,
      ),
      componentCounter = TextComponent(
        position: size,
        anchor: Anchor.bottomRight,
        priority: 1,
      ),
    ]);

    add(EnemyCreator(audioController: audioController));
    player.beginFire();
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = 'Score: $_score';
    componentCounter.text = 'Components: ${children.length}';
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.position += info.delta.global;
  }

  void increaseScore() {
    _score++;
    if (_score == 30) {
      add(FireBoostCreator(audioController: audioController));
    }
  }
}
