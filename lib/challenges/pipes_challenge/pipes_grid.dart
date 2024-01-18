import 'package:endless_runner/challenges/pipes_challenge/pipe_item.dart';
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
  static const _itemsInRow = 5;

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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 300),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _itemsInRow,
          childAspectRatio: 1,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemCount: 15,
        itemBuilder: (context, index) {
          return PipeItem(
            row: PipesHelper.getRowNumber(index, _itemsInRow),
            column: PipesHelper.getColumnNumber(index, _itemsInRow),
          );
        },
      ),
    );
  }
}