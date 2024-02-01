import 'dart:math';

import 'package:endless_runner/flame_game/components/lamp_point.dart';
import 'package:endless_runner/flame_game/endless_world.dart';
import 'package:flame/components.dart';

class LampRowCreator extends TimerComponent with HasGameReference, HasWorldReference<EndlessWorld> {
  final Random random = Random();

  LampRowCreator()
      : super(
          period: 1,
          repeat: true,
          removeOnFinish: true,
        );

  @override
  void onTick() {
    final int numberOfComponents = random.nextInt(3) + 1;

    addAll(
      List.generate(
        numberOfComponents,
        (index) => Lamp.random(
          random: random,
          xPosition: game.size.x / 2 + index * 150,
        ),
      ),
    );
  }
}
