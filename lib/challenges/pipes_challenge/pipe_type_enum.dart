import 'package:endless_runner/challenges/pipes_challenge/pipe_item_widgets.dart';
import 'package:flutter/material.dart';

enum PipeType {
  straight,
  corner,
  empty;

  Widget getWidget(double angle) {
    return switch (this) {
      PipeType.straight => PipeStraight(angle: angle),
      PipeType.corner => PipeCorner(angle: angle),
      PipeType.empty => const PipeEmpty(),
    };
  }
}
