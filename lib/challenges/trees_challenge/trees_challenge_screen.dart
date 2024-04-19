import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/common_widgets/challenge_app_bar.dart';
import 'package:better_world/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:better_world/challenges/common_widgets/count_down_widget.dart';
import 'package:better_world/challenges/trees_challenge/tree_animation.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/background_widget.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/common/exit_challenge_dialog.dart';
import 'package:better_world/common/info_button.dart';
import 'package:better_world/common/map_button.dart';
import 'package:better_world/main_map/main_map_screen.dart';
import 'package:better_world/player_progress/persistence/database_persistence.dart';
import 'package:better_world/player_progress/persistence/local_player_persistence.dart';
import 'package:better_world/style/overlay_widget.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pausable_timer/pausable_timer.dart';
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
  PausableTimer? _timer;
  int _timeInSeconds = 30;

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
    NavigationHelper.navigateToChallengeResultScreen(
      context,
      challengeController.challengeSummary!,
    );
  }

  void _showIntroDialog() {
    NavigationHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.trees,
        onButtonPressed: () {
          context.pop();
          context.read<ChallengeController>().setCountDown(visible: true);
        },
        onCloseTap: () => context.go(MainMapScreen.routePath),
      ),
    );
  }

  void _plantTree() {
    if (_timer?.isCancelled ?? false) {
      return;
    }
    context.read<AudioController>().playSfx(SfxType.buttonTap);
    _challengeController.addPoints();
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _startTimer() {
    _timer ??= PausableTimer.periodic(
      const Duration(seconds: 1),
      () {
        if (_timeInSeconds <= 0) {
          _timer?.cancel();
          _challengeController.onChallengeFinished(
            challengeType: ChallengeType.trees,
          );
        } else {
          setState(() {
            _timeInSeconds--;
          });
        }
      },
    );
    _timer!.start();
  }

  void _showInfoDialog() {
    _timer?.pause();
    NavigationHelper.show(
      context,
      ChallengeIntroductionDialog(
        challenge: ChallengeType.trees,
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
    final challengeController = context.watch<ChallengeController>();

    return PopScope(
      canPop: false,
      onPopInvoked: (_) => _showExitDialog(),
      child: CountDownWidget(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: ChallengeAppBar(
            score: challengeController.score,
            timeInSeconds: _timeInSeconds,
            countDown: true,
            actions: [
              InfoButton(
                onTap: _showInfoDialog,
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () => _plantTree(),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                BackgroundWidget(
                  assetPath:
                      challengeController.score == 0 ? AssetPaths.treeTrunksBackground : AssetPaths.treeBackground,
                ),
                SafeArea(
                  bottom: false,
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 12,
                      ),
                      itemCount: challengeController.score,
                      itemBuilder: (_, index) => TreeAnimation(
                        index: index,
                        score: challengeController.score,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                if (challengeController.score > 25)
                  Align(
                    alignment: Alignment.center,
                    child: LottieBuilder.asset(AssetPaths.birdsAnimation),
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
                Visibility(
                  visible: challengeController.score == 0 && !challengeController.countDownVisible,
                  child: OverlayWidget(
                    child: Text(
                      'TAP THE SCREEN TO PLANT',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Palette.neutralWhite,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExitDialog() {
    _timer?.pause();
    NavigationHelper.showWithWidgetBinding(
      context,
      ExitChallengeDialog(onContinue: () {
        context.pop();
        _timer?.pause();
      }),
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
