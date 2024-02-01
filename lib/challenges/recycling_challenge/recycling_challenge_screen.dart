import 'dart:async';

import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_app_bar.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:endless_runner/challenges/count_down_widget.dart';
import 'package:endless_runner/challenges/recycling_challenge/bin_widget.dart';
import 'package:endless_runner/challenges/recycling_challenge/garbage_controller.dart';
import 'package:endless_runner/challenges/recycling_challenge/garbage_widget.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/background_widget.dart';
import 'package:endless_runner/common/dialog_helper.dart';
import 'package:endless_runner/common/exit_challenge_dialog.dart';
import 'package:endless_runner/common/icon_button.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecyclingChallengeScreen extends StatelessWidget {
  const RecyclingChallengeScreen({super.key, this.onTapOffset});

  static const String routePath = '/recycling-challenge';

  final Offset? onTapOffset;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChallengeController(
            databasePersistence: context.read<DatabasePersistence>(),
            localPlayerPersistence: context.read<LocalPlayerPersistence>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => GarbageController(),
        ),
      ],
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
  late ChallengeController _challengeController;
  Timer? _timer;
  int _timeInSeconds = 0;
  static const int _maxPoints = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIntroDialog();

      _challengeController = context.read<ChallengeController>();
      _challengeController.addListener(_challengeListener);

      final garbageController = Provider.of<GarbageController>(context, listen: false);
      garbageController.addListener(() {
        _garbageListener(garbageController);
      });
    });
  }

  void _showIntroDialog() {
    DialogHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.recycling,
        onButtonPressed: () {
          context.pop();
          context.read<ChallengeController>().setCountDown(visible: true);
        },
      ),
    );
  }

  void _garbageListener(GarbageController garbageController) {
    if (garbageController.challengeCompleted) {
      int score = _maxPoints - _timeInSeconds;
      if (score <= 0) {
        score = 1;
      }
      _challengeController.addPoints(points: score);
      _challengeController.onChallengeFinished(
        challengeType: ChallengeType.recycling,
        timeInSec: _timeInSeconds,
      );
    }
  }

  void _challengeListener() {
    if (!mounted) {
      return;
    }
    if (_challengeController.startChallengeTimer) {
      _startTimer();
    }
    if (_challengeController.challengeSummary != null) {
      _goToSummaryScreen();
    }
  }

  void _startTimer() {
    _timer ??= Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _timeInSeconds++;
        });
      },
    );
  }

  void _goToSummaryScreen() {
    context.go(
      ChallengeCompletedScreen.routePath,
      extra: _challengeController.challengeSummary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        _showExitDialog();
      },
      child: CountDownWidget(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: ChallengeAppBar(
            timeInSeconds: _timeInSeconds,
            countDown: false,
          ),
          body: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              const BackgroundWidget(assetPath: AssetPaths.recyclingBackground),
              const Padding(
                padding: EdgeInsets.only(top: kToolbarHeight + 8),
                child: GarbageWidget(),
              ),
              const Positioned(
                bottom: -30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BinWidget(
                      dumpsterType: BinType.organic,
                    ),
                    gap24,
                    BinWidget(
                      dumpsterType: BinType.plasticMetal,
                    ),
                    gap24,
                    BinWidget(
                      dumpsterType: BinType.glass,
                    ),
                    gap24,
                    BinWidget(
                      dumpsterType: BinType.paper,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 36,bottom: 24),
                  child: GameIconButton(
                    onTap: () => _showExitDialog(),
                    iconName: AssetPaths.iconsMap,
                    width: 56,
                    height: 56,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _challengeController.dispose();
    super.dispose();
  }

  void _showExitDialog() {
    DialogHelper.show(
      context,
      const ExitChallengeDialog(),
    );
  }
}
