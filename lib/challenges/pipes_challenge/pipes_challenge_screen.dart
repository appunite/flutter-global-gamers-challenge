import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_app_bar.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:endless_runner/challenges/common_widgets/count_down_widget.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_controller.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_grid.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/background_widget.dart';
import 'package:endless_runner/common/dialog_helper.dart';
import 'package:endless_runner/common/exit_challenge_dialog.dart';
import 'package:endless_runner/common/info_button.dart';
import 'package:endless_runner/common/map_button.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:provider/provider.dart';

class PipesChallengeScreen extends StatelessWidget {
  const PipesChallengeScreen({super.key, this.onTapOffset});

  static const String routePath = '/pipes-challenge';

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
          create: (_) => PipesController(),
        ),
      ],
      child: const _PipesChallengeBodyScreen(),
    );
  }
}

class _PipesChallengeBodyScreen extends StatefulWidget {
  const _PipesChallengeBodyScreen();

  @override
  State<_PipesChallengeBodyScreen> createState() => _PipesChallengeBodyScreenState();
}

class _PipesChallengeBodyScreenState extends State<_PipesChallengeBodyScreen> {
  late ChallengeController _challengeController;
  PausableTimer? _timer;
  int _timeInSeconds = 0;
  static const int _maxPoints = 60;

  @override
  void initState() {
    super.initState();
    _setControllers();
  }

  void _setControllers() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIntroDialog();

      _challengeController = context.read<ChallengeController>();
      _challengeController.addListener(_challengeListener);

      final pipesController = Provider.of<PipesController>(context, listen: false);
      pipesController.addListener(() {
        _pipesListener(pipesController);
      });
    });
  }

  void _showIntroDialog() {
    NavigationHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.pipelines,
        onButtonPressed: () {
          context.pop();
          context.read<ChallengeController>().setCountDown(visible: true);
        },
      ),
    );
  }

  void _showInfoDialog() {
    _timer?.pause();
    NavigationHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.pipelines,
        onCloseTap: () => _popAndResume(),
        onButtonPressed: () => _popAndResume(),
      ),
    );
  }

  void _popAndResume() {
    context.pop();
    _timer?.start();
  }

  void _pipesListener(PipesController pipesController) {
    if (pipesController.challengeCompleted) {
      int score = _maxPoints - _timeInSeconds;
      if (score <= 0) {
        score = 1;
      }
      _challengeController.addPoints(points: score);
      //TODO animation - delay
      _challengeController.onChallengeFinished(
        challengeType: ChallengeType.pipelines,
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
      _goToSummaryScreen(_challengeController);
    }
  }

  void _goToSummaryScreen(ChallengeController challengeController) {
    NavigationHelper.navigateToChallengeResultScreen(
      context,
      challengeController.challengeSummary!,
    );
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CountDownWidget(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: ChallengeAppBar(
            actions: [
              InfoButton(
                onTap: () => _showInfoDialog(),
              ),
            ],
            timeInSeconds: _timeInSeconds,
            countDown: false,
          ),
          body: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              const BackgroundWidget(assetPath: AssetPaths.pipesBackground),
              const Padding(
                padding: EdgeInsets.only(top: kToolbarHeight + 8),
                child: PipesGrid(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 36, bottom: 24),
                  child: MapButton(
                    onTap: _showExitDialog,
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
    _timer?.pause();
    NavigationHelper.showWithWidgetBinding(
      context,
      ExitChallengeDialog(onContinue: () {
        context.pop();
        _timer?.start();
      }),
    );
  }
}
