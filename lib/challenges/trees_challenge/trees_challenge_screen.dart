import 'dart:async';

import 'package:endless_runner/challenges/challenge_start_controller.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:endless_runner/challenges/count_down_widget.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TreesChallengeScreen extends StatelessWidget {
  const TreesChallengeScreen({super.key});

  static const String routePath = '/trees-challenge';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChallengeStartController(),
      child: const TreesChallengeBodyScreen(),
    );
  }
}

class TreesChallengeBodyScreen extends StatefulWidget {
  const TreesChallengeBodyScreen({super.key});

  @override
  State<TreesChallengeBodyScreen> createState() => _TreesChallengeBodyScreenState();
}

class _TreesChallengeBodyScreenState extends State<TreesChallengeBodyScreen> {
  late int _treesCount = 0;
  final ScrollController _scrollController = ScrollController();
  late int _secondsLeft = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIntroDialog();

      final challengeStartController = Provider.of<ChallengeStartController>(context, listen: false);
      challengeStartController.addListener(() {
        if (challengeStartController.startChallengeTimer) {
          startTimer();
        }
      });
    });
  }

  void _showIntroDialog() {
    DialogHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.trees,
        onButtonPressed: () {
          context.pop();
          context.read<ChallengeStartController>().setCountDown(visible: true);
        },
      ),
    );
  }

  void _plantTree() {
    setState(() {
      _treesCount++;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CountDownWidget(
        child: Scaffold(
          backgroundColor: Colors.green,
          body: SafeArea(
            child: Stack(
              children: [
                GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 12,
                  ),
                  itemCount: _treesCount,
                  itemBuilder: (_, __) => Image.asset(
                    AssetPaths.tree,
                    fit: BoxFit.contain,
                    width: 24,
                    height: 24,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    formatTime(_secondsLeft),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: BackButton(onPressed: context.pop),
                ),
              ],
            ),
          ),
          floatingActionButton: ElevatedButton(
            onPressed: _plantTree,
            child: const Text('Plant tree'),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_secondsLeft > 0) {
          setState(
            () => _secondsLeft--,
          );
        } else {
          timer.cancel();
          _showFinishDialog();
        }
      },
    );
  }

  void _showFinishDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        alignment: Alignment.center,
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Time is over!\n Awesome! You planted $_treesCount trees!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => context
              ..pop()
              ..pop(),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
