import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/challenges/challenge_controller.dart';
import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/common_widgets/challenge_introduction_dialog.dart';
import 'package:better_world/challenges/lights_out_challenge/count_down_overlay.dart';
import 'package:better_world/challenges/ocean_shooter/ocean_challenge_game.dart';
import 'package:better_world/common/exit_challenge_dialog.dart';
import 'package:better_world/common/info_button.dart';
import 'package:better_world/common/map_button.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/common/points_counter.dart';
import 'package:better_world/common/timer_widget.dart';
import 'package:better_world/main_map/main_map_screen.dart';
import 'package:better_world/player_progress/persistence/database_persistence.dart';
import 'package:better_world/player_progress/persistence/local_player_persistence.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OceanChallengeScreen extends StatelessWidget {
  const OceanChallengeScreen({super.key});

  static const String routePath = '/ocean-shooter-challenge';

  static const String winDialogKey = 'win_dialog';
  static const String loseDialogKey = 'lose_dialog';
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
      child: const _OceanChallengeScreenBody(),
    );
  }
}

class _OceanChallengeScreenBody extends StatefulWidget {
  const _OceanChallengeScreenBody();

  @override
  State<_OceanChallengeScreenBody> createState() => _OceanChallengeScreenBodyState();
}

class _OceanChallengeScreenBodyState extends State<_OceanChallengeScreenBody> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: GameWidget<OceanChallengeGame>(
        game: OceanChallengeGame(
          audioController: audioController,
          challengeController: context.read<ChallengeController>(),
        ),
        overlayBuilderMap: {
          OceanChallengeScreen.introductionDialogKey: (context, OceanChallengeGame game) {
            return Center(
              child: ChallengeIntroductionDialog(
                onCloseTap: () => context.go(MainMapScreen.routePath),
                challenge: ChallengeType.ocean,
                onButtonPressed: () {
                  context.read<ChallengeController>().setCountDown(visible: true);
                  game.overlays.remove(OceanChallengeScreen.introductionDialogKey);
                },
              ),
            );
          },
          OceanChallengeScreen.countDownKey: (context, OceanChallengeGame game) {
            return CountDownFlameOverlay(
              challengeController: context.read<ChallengeController>(),
              animationController: _animationController,
            );
          },
          OceanChallengeScreen.mapButtonKey: (context, OceanChallengeGame game) {
            return Positioned(
              bottom: 32,
              left: 24,
              child: MapButton(
                onTap: () => _showExitDialog(game),
              ),
            );
          },
          OceanChallengeScreen.appBarKey: (context, OceanChallengeGame game) {
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
                    timeInSeconds: game.timeInSeconds,
                    countDown: true,
                  ),
                ],
              ),
            );
          },
          OceanChallengeScreen.infoButtonKey: (context, OceanChallengeGame game) {
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
                      challenge: ChallengeType.ocean,
                      onCloseTap: () => _closeAndResume(context, game),
                      onButtonPressed: () => _closeAndResume(context, game),
                    ),
                  );
                }),
              ),
            );
          },
          OceanChallengeScreen.winDialogKey: (BuildContext context, OceanChallengeGame game) {
            context.read<ChallengeController>().addListener(() {
              if (context.read<ChallengeController>().challengeSummary != null) {
                NavigationHelper.navigateToChallengeResultScreen(
                  context,
                  context.read<ChallengeController>().challengeSummary!,
                );
              }
            });
            return const SizedBox.shrink();
          },
          OceanChallengeScreen.loseDialogKey: (BuildContext context, OceanChallengeGame game) {
            NavigationHelper.navigateToChallengeResultScreen(
              context,
              context.read<ChallengeController>().challengeSummary!,
            );
            return const SizedBox.shrink();
          },
        },
      ),
    );
  }

  void _closeAndResume(BuildContext context, OceanChallengeGame game) {
    context.pop();
    game.resumeEngine();
  }

  void _showExitDialog(OceanChallengeGame game) {
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
