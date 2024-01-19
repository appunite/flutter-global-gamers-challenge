import 'package:endless_runner/challenges/ocean_shooter/components/enemy_creator.dart';
import 'package:endless_runner/challenges/ocean_shooter/components/player_component.dart';
import 'package:endless_runner/challenges/ocean_shooter/components/star_background_creator.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class OceanChallengeScreen extends FlameGame with PanDetector, HasCollisionDetection {
  static const String routePath = '/ocean-shooter-challenge';

  late final PlayerComponent player;
  late final TextComponent componentCounter;
  late final TextComponent scoreText;
  late int _score = 0;

  @override
  Future<void> onLoad() async {
    add(player = PlayerComponent());
    addAll([
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

    add(EnemyCreator());
    add(StarBackGroundCreator());
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
  }
}

class RogueShooterWidget extends StatelessWidget {
  const RogueShooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: OceanChallengeScreen(),
      loadingBuilder: (_) => const Center(
        child: Text('Loading'),
      ),
    );
  }
}
