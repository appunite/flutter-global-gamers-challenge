import 'package:endless_runner/challenges/pipes_challenge/pipe_item.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_controller.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_helper.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
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
      builder: (context) {
        final palette = context.read<Palette>();

        return Center(
          child: NesContainer(
            backgroundColor: palette.backgroundPlaySession.color,
            width: 420,
            height: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Well done!',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'You completed pipes challenge!',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                NesButton(
                  onPressed: () {
                    context.go('/');
                  },
                  type: NesButtonType.normal,
                  child: const Text('Check your City!'),
                ),
              ],
            ),
          ),
        );
      },
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
