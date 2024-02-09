import 'dart:math';

import 'package:better_world/challenges/lights_out_challenge/components/lamp.dart';
import 'package:better_world/challenges/lights_out_challenge/endless_world.dart';
import 'package:flame/components.dart';

class LampRowCreator extends TimerComponent with HasGameReference, HasWorldReference<EndlessWorld> {
  LampRowCreator()
      : super(
          period: 1,
          repeat: true,
          removeOnFinish: true,
        );

  final Random random = Random();

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
