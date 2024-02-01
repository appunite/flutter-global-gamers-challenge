import 'package:endless_runner/challenges/pipes_challenge/pipe_item.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipe_item_widgets.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipe_type_enum.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_helper.dart';
import 'package:flutter/material.dart';

class PipesGrid extends StatefulWidget {
  const PipesGrid({super.key});

  @override
  State<PipesGrid> createState() => _PipesGridState();
}

class _PipesGridState extends State<PipesGrid> {
  static const _itemsInRow = 8;
  late final List<PipeType> _itemsList = [
    /// I row
    PipeType.straight,
    PipeType.corner,
    PipeType.corner,
    PipeType.straight,
    PipeType.straight,
    PipeType.straight,
    PipeType.straight,
    PipeType.corner,

    /// II row
    PipeType.empty,
    PipeType.straight,
    PipeType.corner,
    PipeType.straight,
    PipeType.corner,
    PipeType.empty,
    PipeType.empty,
    PipeType.straight,

    /// III row
    PipeType.empty,
    PipeType.straight,
    PipeType.empty,
    PipeType.empty,
    PipeType.straight,
    PipeType.corner,
    PipeType.straight,
    PipeType.corner,

    /// IV row
    PipeType.empty,
    PipeType.corner,
    PipeType.straight,
    PipeType.straight,
    PipeType.corner,
    PipeType.empty,
    PipeType.empty,
    PipeType.empty,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PipeWheel(),
        SizedBox(
          width: 550,
          height: 450,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _itemsInRow,
              childAspectRatio: 1,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            itemCount: _itemsList.length,
            itemBuilder: (context, index) {
              return PipeItem(
                row: PipesHelper.getRowNumber(index, _itemsInRow),
                column: PipesHelper.getColumnNumber(index, _itemsInRow),
                pipeType: _itemsList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
