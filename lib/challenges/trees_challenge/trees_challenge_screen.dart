import 'dart:async';

import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/challenges/challenge_introduction_dialog.dart';
import 'package:endless_runner/common/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TreesChallengeScreen extends StatefulWidget {
  const TreesChallengeScreen({super.key});

  static const String routePath = '/trees-challenge';

  @override
  State<TreesChallengeScreen> createState() => _TreesChallengeScreenState();
}

class _TreesChallengeScreenState extends State<TreesChallengeScreen> {
  late int _treesCount = 0;
  final ScrollController _scrollController = ScrollController();
  late int _secondsLeft = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _showIntroDialog();
  }

  void _showIntroDialog() {
    DialogHelper.showWithWidgetBinding(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.trees,
        onButtonPressed: () {
          context.pop();
          startTimer();
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
