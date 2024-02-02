import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

/// The [JumpEffect] is simply a [MoveByEffect] which has the properties of the
/// effect pre-defined.
class JumpEffect extends MoveByEffect {
  JumpEffect(Vector2 offset) : super(Vector2(0, offset.y), EffectController(duration: 0.3, curve: Curves.ease));
}
