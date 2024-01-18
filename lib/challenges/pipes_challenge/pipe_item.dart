import 'package:endless_runner/challenges/pipes_challenge/pipes_controller.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PipeItem extends StatefulWidget {
  const PipeItem({
    super.key,
    required this.row,
    required this.column,
  });

  final int row;
  final int column;

  @override
  State<PipeItem> createState() => _PipeItemState();
}

class _PipeItemState extends State<PipeItem> {
  @override
  Widget build(BuildContext context) {
    final pipesController = context.watch<PipesController>();

    return GestureDetector(
      onTap: () => pipesController.itemTurned(
        row: widget.row,
        column: widget.column,
      ),
      child: Transform.rotate(
        angle: pipesController.pipesCurrentAngles[widget.row][widget.column],
        child: Image.asset(AssetPaths.pipe),
      ),
    );
  }
}
