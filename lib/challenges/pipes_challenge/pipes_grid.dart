import 'package:endless_runner/challenges/pipes_challenge/pipe_item.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipe_item_widgets.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipe_type_enum.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_controller.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_helper.dart';
import 'package:endless_runner/common/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PipesGrid extends StatelessWidget {
  const PipesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PipesController(),
      child: const _PipesGridBody(),
    );
  }
}

class _PipesGridBody extends StatefulWidget {
  const _PipesGridBody();

  @override
  State<_PipesGridBody> createState() => _PipesGridBodyState();
}

class _PipesGridBodyState extends State<_PipesGridBody> {
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

  final List firstRow = [
    PipeType.straight,
    PipeType.corner,
    PipeType.corner,
    PipeType.straight,
    PipeType.straight,
    PipeType.straight,
    PipeType.straight,
    PipeType.corner,
  ];
  final List secondRow = [
    PipeType.empty,
    PipeType.straight,
    PipeType.corner,
    PipeType.straight,
    PipeType.corner,
    PipeType.empty,
    PipeType.empty,
    PipeType.straight,
  ];
  final List thirdRow = [
    PipeType.empty,
    PipeType.straight,
    PipeType.empty,
    PipeType.empty,
    PipeType.straight,
    PipeType.corner,
    PipeType.straight,
    PipeType.corner,
  ];
  final List fourthRow = [
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pipesController = Provider.of<PipesController>(context, listen: false);
      pipesController.addListener(() {
        if (pipesController.challengeCompleted) {
          _showCompletionDialog();
        }
      });
    });
  }

  void _showCompletionDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const SuccessDialog(
        challengeName: 'pipes',
      ),
    );
  }

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
