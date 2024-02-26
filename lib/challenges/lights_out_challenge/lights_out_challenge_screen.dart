import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:better_world/challenges/lights_out_challenge/count_down_overlay.dart';
import 'package:better_world/common/exit_challenge_dialog.dart';
import 'package:better_world/common/info_button.dart';
import 'package:better_world/common/map_button.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/common/points_counter.dart';
import 'package:better_world/common/timer_widget.dart';
import 'package:better_world/player_progress/persistence/database_persistence.dart';
import 'package:better_world/player_progress/persistence/local_player_persistence.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import 'endless_runner.dart';

class LightsOutChallengeScreen extends StatelessWidget {
  const LightsOutChallengeScreen({super.key});

  static const String routePath = '/lights-out-challenge';

  static const String winDialogKey = 'win_dialog';
  static const String infoButtonKey = 'info_button';
  static const String mapButtonKey = 'back_buttton';
  static const String appBarKey = 'appBar';
  static const String introductionDialogKey = 'introductionDialog';
  static const String countDownKey = 'countDown';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChallengeController(
        databasePersistence: context.read<DatabasePersistence>(),
        localPlayerPersistence: context.read<LocalPlayerPersistence>(),
      ),
      child: const LightsOutChallengeBodyScreen(),
    );
  }
}

class LightsOutChallengeBodyScreen extends StatefulWidget {
  const LightsOutChallengeBodyScreen({super.key});

  @override
  State<LightsOutChallengeBodyScreen> createState() => _LightsOutChallengeBodyScreenState();
}

class _LightsOutChallengeBodyScreenState extends State<LightsOutChallengeBodyScreen>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Palette.neutralWhite,
      body: GameWidget<EndlessRunner>(
        key: const Key('play session'),
        game: EndlessRunner(
          audioController: audioController,
          challengeController: context.read<ChallengeController>(),
        ),
        overlayBuilderMap: {
          LightsOutChallengeScreen.introductionDialogKey: (context, game) {
            return Center(
              child: ChallengeIntroductionDialog(
                onCloseTap: () => context.go('/'),
                challenge: ChallengeType.lightsOut,
                onButtonPressed: () {
                  context.read<ChallengeController>().setCountDown(visible: true);
                  game.overlays.remove(LightsOutChallengeScreen.introductionDialogKey);
                },
              ),
            );
          },
          LightsOutChallengeScreen.countDownKey: (context, game) {
            return CountDownFlameOverlay(
              challengeController: context.read<ChallengeController>(),
              animationController: _animationController,
            );
          },
          LightsOutChallengeScreen.mapButtonKey: (context, game) {
            return Positioned(
              bottom: 32,
              left: 24,
              child: MapButton(
                onTap: () => _showExitDialog(game),
              ),
            );
          },
          LightsOutChallengeScreen.appBarKey: (context, game) {
            return Positioned(
              top: 10,
              left: width / 2 - 150,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PointsCounter(pointsCount: context.read<ChallengeController>().score),
                  gap16,
                  TimerWidget(
                    timeInSeconds: game.world.timeInSeconds,
                    countDown: true,
                  ),
                ],
              ),
            );
          },
          LightsOutChallengeScreen.infoButtonKey: (context, game) {
            return Positioned(
              top: 10,
              right: 0,
              child: SafeArea(
                top: false,
                bottom: false,
                left: false,
                child: InfoButton(onTap: () {
                  game.pauseEngine();
                  NavigationHelper.show(
                    context,
                    ChallengeIntroductionDialog(
                      challenge: ChallengeType.lightsOut,
                      onCloseTap: () => _closeAndResume(context, game),
                      onButtonPressed: () => _closeAndResume(context, game),
                    ),
                  );
                }),
              ),
            );
          },
          LightsOutChallengeScreen.winDialogKey: (BuildContext context, EndlessRunner game) {
            final challengeController = context.read<ChallengeController>();
            challengeController.addListener(() {
              if (challengeController.challengeSummary != null) {
                NavigationHelper.navigateToChallengeResultScreen(
                  context,
                  challengeController.challengeSummary!,
                );
              }
            });
            return const SizedBox.shrink();
          },
        },
      ),
    );
  }

  void _closeAndResume(BuildContext context, EndlessRunner game) {
    context.pop();
    game.resumeEngine();
  }

  void _showExitDialog(EndlessRunner game) {
    game.pauseEngine();
    NavigationHelper.show(
      context,
      ExitChallengeDialog(onContinue: () {
        game.resumeEngine();
        context.pop();
      }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
