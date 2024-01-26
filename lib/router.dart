import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_no_score_screen.dart';
import 'package:endless_runner/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:endless_runner/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:endless_runner/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:endless_runner/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:endless_runner/common/google_wallet_demo.dart';
import 'package:endless_runner/leaderboard/leaderboard.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'flame_game/game_screen.dart';
import 'level_selection/levels.dart';
import 'main_menu/main_menu_screen.dart';
import 'style/page_transition.dart';
import 'style/palette.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
      routes: [
        GoRoute(
          path: 'play',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('level'),
            color: context.watch<Palette>().backgroundPlaySession.color,
            child: GameScreen(level: gameLevels[0]),
          ),
        ),
      ],
    ),
    GoRoute(
      path: SolarPanelChallengeScreen.routePath,
      builder: (context, state) => const SolarPanelChallengeScreen(
        key: Key('solar-panel-scratcher'),
      ),
    ),
    GoRoute(
      path: RecyclingChallengeScreen.routePath,
      builder: (context, state) => const RecyclingChallengeScreen(
        key: Key('recycling-challenge'),
      ),
    ),
    GoRoute(
      path: TreesChallengeScreen.routePath,
      builder: (context, state) => const TreesChallengeScreen(
        key: Key('trees-challenge'),
      ),
    ),
    GoRoute(
      path: PipesChallengeScreen.routePath,
      builder: (context, state) => const PipesChallengeScreen(
        key: Key('pipes-challenge'),
      ),
    ),
    GoRoute(
      path: GoogleWalletDemoScreen.routePath,
      builder: (context, state) => const GoogleWalletDemoScreen(
        key: Key('google-wallet-demo'),
      ),
    ),
    GoRoute(
      path: LeaderboardScreen.routePath,
      builder: (context, state) => const LeaderboardScreen(
        key: Key('leaderboard'),
      ),
    ),
    GoRoute(
      path: ChallengeCompletedScreen.routePath,
      builder: (context, state) => ChallengeCompletedScreen(
        key: const Key('challenge-completed'),
        //TODO: get it from state
        challengeType: ChallengeType.ocean,
        onPrimaryButtonPressed: () {
          context.pop();
        },
        onSecondaryButtonPressed: () {},
      ),
    ),
    GoRoute(
      path: ChallengeNoScoreScreen.routePath,
      builder: (context, state) => ChallengeNoScoreScreen(
        key: const Key('challenge-no-score'),
        //TODO: get it from state
        challengeType: ChallengeType.ocean,
        onPrimaryButtonPressed: () {
          context.pop();
        },
        onSecondaryButtonPressed: () {},
      ),
    ),
    GoRoute(
      path: OceanChallengeScreen.routePath,
      pageBuilder: (context, state) {
        return buildPageTransition<void>(
          color: context.watch<Palette>().backgroundPlaySession.color,
          child: GameWidget(game: OceanChallengeScreen()),
        );
      },
    ),
  ],
);
