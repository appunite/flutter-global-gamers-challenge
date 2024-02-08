import 'package:endless_runner/audio/audio_controller.dart';
import 'package:endless_runner/audio/sounds.dart';
import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_app_bar.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:endless_runner/challenges/common_widgets/count_down_widget.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/background_widget.dart';
import 'package:endless_runner/common/exit_challenge_dialog.dart';
import 'package:endless_runner/common/info_button.dart';
import 'package:endless_runner/common/map_button.dart';
import 'package:endless_runner/common/navigation_helper.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/scratcher.dart';

class SolarPanelChallengeScreen extends StatelessWidget {
  const SolarPanelChallengeScreen({super.key});

  static const String routePath = '/solar-panel-scratcher';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChallengeController(
        databasePersistence: context.read<DatabasePersistence>(),
        localPlayerPersistence: context.read<LocalPlayerPersistence>(),
      ),
      child: const _SolarPanelChallengeBodyScreen(),
    );
  }
}

class _SolarPanelChallengeBodyScreen extends StatefulWidget {
  const _SolarPanelChallengeBodyScreen();

  @override
  State<_SolarPanelChallengeBodyScreen> createState() => _SolarPanelChallengeBodyScreenState();
}

class _SolarPanelChallengeBodyScreenState extends State<_SolarPanelChallengeBodyScreen> {
  late ChallengeController _challengeController;
  late double _scratchedValue = 0;
  late int _timeInSeconds = 10;
  PausableTimer? _timer;

  @override
  void initState() {
    super.initState();
    _setControllers();
  }

  void _setControllers() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIntroDialog();

      _challengeController = context.read<ChallengeController>();
      _challengeController.addListener(_solarPanelListener);
    });
  }

  void _solarPanelListener() {
    if (mounted) {
      if (_challengeController.startChallengeTimer) {
        _startTimer();
      }
      if (_challengeController.challengeSummary != null) {
        _goToSummaryScreen();
      }
    }
  }

  void _startTimer() {
    _timer ??= PausableTimer.periodic(
      const Duration(seconds: 1),
      () {
        if (_timeInSeconds == 0) {
          _timer?.cancel();
          _challengeController
            ..addPoints(points: _scratchedValue.toInt())
            ..onChallengeFinished(challengeType: ChallengeType.solarPanel);
        } else {
          setState(() {
            _timeInSeconds--;
          });
        }
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

  void _showIntroDialog() {
    NavigationHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.solarPanel,
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
        challenge: ChallengeType.solarPanel,
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
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;

    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        _showExitDialog();
      },
      child: CountDownWidget(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: ChallengeAppBar(
            score: _scratchedValue.toInt(),
            timeInSeconds: _timeInSeconds,
            countDown: true,
            actions: [
              InfoButton(onTap: () => _showInfoDialog()),
            ],
          ),
          body: Stack(
            children: [
              const BackgroundWidget(
                assetPath: AssetPaths.treeBackground,
              ),
              SafeArea(
                child: Scratcher(
                  rebuildOnResize: false,
                  brushSize: 40,
                  threshold: 100,
                  image: Image.asset(AssetPaths.panelDirty),
                  onScratchStart: () => context.read<AudioController>().playSfx(SfxType.panelCleaning),
                  onScratchEnd: () => context.read<AudioController>().stopSfx(),
                  onChange: (double value) {
                    setState(() {
                      _scratchedValue = value;
                    });
                  },
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: SvgPicture.asset(
                      AssetPaths.panelClean,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
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

  @override
  void dispose() {
    _timer?.cancel();
    _challengeController.dispose();
    super.dispose();
  }

  void _showExitDialog() {
    NavigationHelper.showWithWidgetBinding(
      context,
      const ExitChallengeDialog(),
    );
  }
}
