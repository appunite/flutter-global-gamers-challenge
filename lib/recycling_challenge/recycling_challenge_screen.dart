import 'package:endless_runner/recycling_challenge/dumpster_widget.dart';
import 'package:endless_runner/recycling_challenge/garbage_controller.dart';
import 'package:endless_runner/recycling_challenge/garbage_widget.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

class RecyclingChallengeScreen extends StatelessWidget {
  const RecyclingChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GarbageController(),
      child: const _RecyclingChallengeScreenBody(),
    );
  }
}

class _RecyclingChallengeScreenBody extends StatefulWidget {
  const _RecyclingChallengeScreenBody();

  @override
  State<_RecyclingChallengeScreenBody> createState() => _RecyclingChallengeScreenBodyState();
}

class _RecyclingChallengeScreenBodyState extends State<_RecyclingChallengeScreenBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final garbageController = Provider.of<GarbageController>(context, listen: false);
      garbageController.addListener(() {
        if (garbageController.challengeCompleted) {
          _showCompletionDialog();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFEDEDED),
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const GarbageWidget(),
                Positioned(
                  bottom: -70,
                  left: width / 6,
                  child: const DumpsterWidget(
                    dumpsterType: DumpsterType.recyclable,
                  ),
                ),
                Positioned(
                  bottom: -70,
                  left: width / 2,
                  child: const DumpsterWidget(
                    dumpsterType: DumpsterType.other,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: BackButton(onPressed: context.pop),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                  'You completed Recycling challenge!',
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
}
