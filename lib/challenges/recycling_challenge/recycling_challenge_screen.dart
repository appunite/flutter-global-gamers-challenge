import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/common_widgets/challenge_app_bar.dart';
import 'package:better_world/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:better_world/challenges/common_widgets/count_down_widget.dart';
import 'package:better_world/challenges/recycling_challenge/bin_widget.dart';
import 'package:better_world/challenges/recycling_challenge/garbage_controller.dart';
import 'package:better_world/challenges/recycling_challenge/garbage_widget.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/background_widget.dart';
import 'package:better_world/common/exit_challenge_dialog.dart';
import 'package:better_world/common/info_button.dart';
import 'package:better_world/common/map_button.dart';
import 'package:better_world/main_map/main_map_screen.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/player_progress/persistence/database_persistence.dart';
import 'package:better_world/player_progress/persistence/local_player_persistence.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pausable_timer/pausable_timer.dart';
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
  PausableTimer? _timer;
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
    NavigationHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.recycling,
        onButtonPressed: () {
          context.pop();
          context.read<ChallengeController>().setCountDown(visible: true);
        },
        onCloseTap: () => context.go(MainMapScreen.routePath),
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
    _timer ??= PausableTimer.periodic(
      const Duration(seconds: 1),
      () {
        setState(() {
          _timeInSeconds++;
        });
      },
    );
    _timer!.start();
  }

  void _goToSummaryScreen() {
    NavigationHelper.navigateToChallengeResultScreen(
      context,
      _challengeController.challengeSummary!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => _showExitDialog(),
      child: CountDownWidget(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: ChallengeAppBar(
            timeInSeconds: _timeInSeconds,
            countDown: false,
            actions: [
              InfoButton(onTap: _showInfoDialog),
            ],
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
                  padding: const EdgeInsets.only(left: 36, bottom: 24),
                  child: MapButton(
                    onTap: () => _showExitDialog(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExitDialog() {
    _timer?.pause();
    NavigationHelper.show(
      context,
      ExitChallengeDialog(onContinue: () {
        context.pop();
        _timer?.start();
      }),
    );
  }

  void _showInfoDialog() {
    _timer?.pause();
    NavigationHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.recycling,
        onCloseTap: () => _popAndResume(),
        onButtonPressed: () => _popAndResume(),
      ),
    );
  }

  void _popAndResume() {
    context.pop();
    _timer?.start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _challengeController.dispose();
    super.dispose();
  }
}
