import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/challenges/pipes_challenge/pipe_type_enum.dart';
import 'package:better_world/challenges/pipes_challenge/pipes_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PipeItem extends StatefulWidget {
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
  State<PipeItem> createState() => _PipeItemState();
}

class _PipeItemState extends State<PipeItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addListener(() {
      setState(() {});
      if (_controller.isCompleted) {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pipesController = context.watch<PipesController>();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!pipesController.challengeCompleted && !_isLastPipe) {
          context.read<AudioController>().playSfx(SfxType.pipe);
          pipesController.itemTurned(
            row: widget.row,
            column: widget.column,
            pipeType: widget.pipeType,
          );
          _controller.forward(from: 0);
        }
      },
      child: Transform.scale(
        scale: _animation.value,
        child: Transform.rotate(
          angle: pipesController.pipesCurrentAngles[widget.row][widget.column],
          child: widget.pipeType.getWidget(
            pipesController.pipesCurrentAngles[widget.row][widget.column],
            lastPipe: _isLastPipe,
          ),
        ),
      ),
    );
  }

  bool get _isLastPipe => widget.row == 2 && widget.column == 5;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
