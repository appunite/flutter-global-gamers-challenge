import 'dart:async';

import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_no_score_screen.dart';
import 'package:endless_runner/challenges/count_down_widget.dart';
import 'package:endless_runner/challenges/trees_challenge/trees_challenge_controller.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/background_widget.dart';
import 'package:endless_runner/common/dialog_helper.dart';
import 'package:endless_runner/common/points_counter.dart';
import 'package:endless_runner/common/timer_widget.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TreesChallengeScreen extends StatelessWidget {
  const TreesChallengeScreen({super.key, this.onTapOffset});

  static const String routePath = '/trees-challenge';

  final Offset? onTapOffset;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TreesChallengeController(databasePersistence: DatabasePersistence(), startingTimeInSeconds: 15),
      child: const _TreesChallengeBodyScreen(),
    );
  }
}

class _TreesChallengeBodyScreen extends StatefulWidget {
  const _TreesChallengeBodyScreen();

  @override
  State<_TreesChallengeBodyScreen> createState() => _TreesChallengeBodyScreenState();
}

class _TreesChallengeBodyScreenState extends State<_TreesChallengeBodyScreen> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIntroDialog();

      final challengeController = Provider.of<TreesChallengeController>(context, listen: false);
      challengeController.addListener(() {
        if (challengeController.startChallengeTimer) {
          _startTimer(challengeController);
        }
        if (challengeController.challengeSummary != null) {
          if (challengeController.challengeSummary!.score > 0) {
            context.go(
              ChallengeCompletedScreen.routePath,
              extra: challengeController.challengeSummary,
            );
          } else {
            context.go(
              ChallengeNoScoreScreen.routePath,
              extra: challengeController.challengeSummary,
            );
          }
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
          context.read<TreesChallengeController>().setCountDown(visible: true);
        },
      ),
    );
  }

  void _plantTree(TreesChallengeController challengeController) {
    challengeController.addPoints();
    // setState(() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    // });
  }

  void _startTimer(TreesChallengeController controller) {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (controller.challengeTime < 0) {
          timer.cancel();
          _onChallengeFinished(controller);
        } else {
          controller.updateTime(countDown: true);
        }
      },
    );
  }

  void _onChallengeFinished(TreesChallengeController controller) {
    //TODO wywołać metodę z kontrollera (nie potrzeba osobnej metody)
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final challengeController = context.watch<TreesChallengeController>();

    return PopScope(
      canPop: false,
      child: CountDownWidget(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PointsCounter(pointsCount: challengeController.score),
                gap16,
                TimerWidget(
                  timeInSeconds: challengeController.challengeTime,
                  countDown: true,
                ),
              ],
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              const BackgroundWidget(
                assetPath: AssetPaths.treeBackground,
              ),
              GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 12,
                ),
                itemCount: challengeController.score,
                itemBuilder: (_, __) => SvgPicture.asset(
                  AssetPaths.tree,
                  fit: BoxFit.contain,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          floatingActionButton: MainButton(
            onPressed: (_) => _plantTree(challengeController),
            text: 'Plant a Tree',
            width: 220,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
