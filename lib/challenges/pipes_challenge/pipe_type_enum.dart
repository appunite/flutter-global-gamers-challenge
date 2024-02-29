import 'package:better_world/challenges/pipes_challenge/pipe_item_widgets.dart';
import 'package:flutter/material.dart';

enum PipeType {
  straight,
  corner,
  empty;

  Widget getWidget(double angle, {bool lastPipe = false}) {
    return switch (this) {
      PipeType.straight => PipeStraight(angle: angle),
      PipeType.corner => PipeCorner(angle: angle, lastPipe: lastPipe),
      PipeType.empty => const PipeEmpty(),
    };
  }
}
