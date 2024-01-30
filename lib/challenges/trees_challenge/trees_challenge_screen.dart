import 'dart:async';

import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_no_score_screen.dart';
import 'package:endless_runner/challenges/count_down_widget.dart';
import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/background_widget.dart';
import 'package:endless_runner/common/dialog_helper.dart';
import 'package:endless_runner/common/points_counter.dart';
import 'package:endless_runner/common/timer_widget.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
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
      create: (_) => ChallengeController(
        databasePersistence: context.read<DatabasePersistence>(),
        localPlayerPersistence: context.read<LocalPlayerPersistence>(),
      ),
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
  late ChallengeController _challengeController;
  Timer? _timer;
  int _timeInSeconds = 10;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIntroDialog();

      _challengeController = context.read<ChallengeController>();
      _challengeController.addListener(_listener);
    });
  }

  void _listener() {
    if (mounted) {
      if (_challengeController.startChallengeTimer) {
        _startTimer();
      }
      if (_challengeController.challengeSummary != null) {
        _goToSummaryScreen(_challengeController);
      }
    }
  }

  void _goToSummaryScreen(ChallengeController challengeController) {
    context.go(
      challengeController.challengeSummary!.score > 0
          ? ChallengeCompletedScreen.routePath
          : ChallengeNoScoreScreen.routePath,
      extra: challengeController.challengeSummary,
    );
  }

  void _showIntroDialog() {
    DialogHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.trees,
        onButtonPressed: () {
          context.pop();
          context.read<ChallengeController>().setCountDown(visible: true);
        },
      ),
    );
  }

  void _plantTree() {
    _challengeController.addPoints();
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _startTimer() {
    _timer ??= Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_timeInSeconds <= 0) {
          _timer?.cancel();
          _challengeController.onChallengeFinished(
            challengeType: ChallengeType.trees,
            timeInSec: _timeInSeconds,
          );
        } else {
          setState(() {
            _timeInSeconds--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final challengeController = context.watch<ChallengeController>();

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
                  timeInSeconds: _timeInSeconds,
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
            onPressed: (_) => _plantTree(),
            text: 'Plant a Tree',
            width: 220,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    _challengeController.dispose();
    super.dispose();
  }
}
