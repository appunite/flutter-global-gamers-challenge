import 'package:endless_runner/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:endless_runner/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:endless_runner/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:endless_runner/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:endless_runner/common/google_wallet_demo.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'flame_game/game_screen.dart';
import 'level_selection/level_selection_screen.dart';
import 'level_selection/levels.dart';
import 'main_menu/main_menu_screen.dart';
import 'settings/settings_screen.dart';
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
            key: const ValueKey('play'),
            color: context.watch<Palette>().backgroundLevelSelection.color,
            child: const LevelSelectionScreen(
              key: Key('level selection'),
            ),
          ),
          routes: [
            GoRoute(
              path: 'session/:level',
              pageBuilder: (context, state) {
                final levelNumber = int.parse(state.pathParameters['level']!);
                final level = gameLevels[levelNumber - 1];
                return buildPageTransition<void>(
                  key: const ValueKey('level'),
                  color: context.watch<Palette>().backgroundPlaySession.color,
                  child: GameScreen(level: level),
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: SettingsScreen.routePath,
      builder: (context, state) => const SettingsScreen(
        key: Key('settings'),
      ),
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
        key: Key('pipes-challenge'),
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
