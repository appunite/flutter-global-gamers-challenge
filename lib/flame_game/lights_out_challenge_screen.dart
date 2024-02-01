import 'package:endless_runner/challenges/challenge_controller.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:endless_runner/player_progress/persistence/database_persistence.dart';
import 'package:endless_runner/player_progress/persistence/local_player_persistence.dart';
import 'package:endless_runner/style/main_button.dart';

import '../audio/audio_controller.dart';
import 'endless_runner.dart';
import '../level_selection/levels.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// This widget defines the properties of the game screen.
///
/// It mostly sets up the overlays (widgets shown on top of the Flame game) and
/// the gets the [AudioController] from the context and passes it in to the
/// [EndlessRunner] class so that it can play audio.
class LightsOutChallengeScreen extends StatelessWidget {
  const LightsOutChallengeScreen({required this.level, super.key});

  static const String routePath = '/lights-out-challenge';

  final GameLevel level;

  static const String winDialogKey = 'win_dialog';
  static const String backButtonKey = 'back_buttton';

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    final challengeController = ChallengeController(
      databasePersistence: context.read<DatabasePersistence>(),
      localPlayerPersistence: context.read<LocalPlayerPersistence>(),
    );

    return Scaffold(
      body: GameWidget<EndlessRunner>(
        key: const Key('play session'),
        game: EndlessRunner(
          audioController: audioController,
          challengeController: challengeController,
        ),
        overlayBuilderMap: {
          backButtonKey: (BuildContext context, EndlessRunner game) {
            return Positioned(
              top: 20,
              right: 10,
              child: MainButton(
                onPressed: GoRouter.of(context).pop,
                text: 'Cancel',
              ),
            );
          },
          winDialogKey: (BuildContext context, EndlessRunner game) {
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
}
