import 'dart:math';

import 'package:endless_runner/challenges/ocean_shooter/components/enemy_component.dart';
import 'package:flame/components.dart';

class EnemyCreator extends TimerComponent with HasGameRef {
  final Random random = Random();
  final _halfHeight = EnemyComponent.initialSize.y / 2;

  EnemyCreator() : super(period: 1, repeat: true);

  @override
  void onTick() {
    game.addAll(
      List.generate(
        5,
        (index) => EnemyComponent(
          position: Vector2(
            game.size.x,
            _halfHeight + (game.size.y - _halfHeight) * random.nextDouble(),
          ),
        ),
      ),
    );
  }
}
