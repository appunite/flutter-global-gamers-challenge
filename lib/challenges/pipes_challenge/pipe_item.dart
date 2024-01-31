import 'package:endless_runner/challenges/pipes_challenge/pipe_type_enum.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PipeItem extends StatelessWidget {
  const PipeItem({
    super.key,
    required this.row,
    required this.column,
    required this.pipeType,
  });

  final int row;
  final int column;
  final PipeType pipeType;

  @override
  Widget build(BuildContext context) {
    final pipesController = context.watch<PipesController>();

    return GestureDetector(
      onTap: () => pipesController.itemTurned(
        row: row,
        column: column,
        pipeType: pipeType,
      ),
      child: Transform.rotate(
        angle: pipesController.pipesCurrentAngles[row][column],
        child: pipeType.getWidget(pipesController.pipesCurrentAngles[row][column]),
      ),
    );
  }
}
