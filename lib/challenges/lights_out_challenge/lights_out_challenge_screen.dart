import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:endless_runner/challenges/lights_out_challenge/count_down_overlay.dart';
import 'package:endless_runner/common/points_counter.dart';
import 'package:endless_runner/common/timer_widget.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';

import '../../audio/audio_controller.dart';
import 'endless_runner.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LightsOutChallengeScreen extends StatelessWidget {
  const LightsOutChallengeScreen({super.key});

  static const String routePath = '/lights-out-challenge';

  static const String winDialogKey = 'win_dialog';
  static const String backButtonKey = 'back_buttton';
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
    duration: const Duration(seconds: 3),
  );

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
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
                challenge: ChallengeType.city,
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
          LightsOutChallengeScreen.backButtonKey: (context, game) {
            return Positioned(
              top: 20,
              right: 10,
              child: MainButton(
                onPressed: GoRouter.of(context).pop,
                text: 'Cancel',
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
          LightsOutChallengeScreen.winDialogKey: (BuildContext context, EndlessRunner game) {
            final challengeController = context.read<ChallengeController>();
            challengeController.addListener(() {
              if (challengeController.challengeSummary != null) {
                context.go(
                  ChallengeCompletedScreen.routePath,
                  extra: challengeController.challengeSummary!,
                );
              }
            });
            //TODO badge dialog?
            return const SizedBox.shrink();
          },
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
