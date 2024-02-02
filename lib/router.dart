import 'package:endless_runner/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:endless_runner/challenges/common_widgets/challenge_no_score_screen.dart';
import 'package:endless_runner/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:endless_runner/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:endless_runner/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:endless_runner/challenges/trees_challenge/challenge_summary_entity.dart';
import 'package:endless_runner/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:endless_runner/common/google_wallet_demo.dart';
import 'package:endless_runner/leaderboard/leaderboard_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'challenges/lights_out_challenge/lights_out_challenge_screen.dart';
import 'main_menu/main_menu_screen.dart';
import 'style/page_transition.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(
        key: Key('main menu'),
      ),
    ),
    GoRoute(
      path: LightsOutChallengeScreen.routePath,
      pageBuilder: (context, state) => buildPageTransition<void>(
        key: const ValueKey('lights-out-challenge'),
        child: const LightsOutChallengeScreen(),
      ),
    ),
    GoRoute(
      path: SolarPanelChallengeScreen.routePath,
      pageBuilder: (context, state) => buildPageTransition<void>(
        child: const SolarPanelChallengeScreen(
          key: Key('solar-panel-scratcher'),
        ),
      ),
    ),
    GoRoute(
      path: RecyclingChallengeScreen.routePath,
      pageBuilder: (context, state) => buildPageTransition(
        offset: state.extra as Offset?,
        child: const RecyclingChallengeScreen(
          key: Key('recycling-challenge'),
        ),
      ),
    ),
    GoRoute(
      path: TreesChallengeScreen.routePath,
      pageBuilder: (context, state) => buildPageTransition<void>(
        offset: state.extra as Offset?,
        child: const TreesChallengeScreen(
          key: Key('trees-challenge'),
        ),
      ),
    ),
    GoRoute(
      path: PipesChallengeScreen.routePath,
      pageBuilder: (context, state) => buildPageTransition(
        offset: state.extra as Offset?,
        child: const PipesChallengeScreen(
          key: Key('pipes-challenge'),
        ),
      ),
    ),
    GoRoute(
      path: GoogleWalletDemoScreen.routePath,
      pageBuilder: (context, state) => buildPageTransition(
        child: const GoogleWalletDemoScreen(
          key: Key('google-wallet-demo'),
        ),
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
      pageBuilder: (context, state) => buildPageTransition(
        child: ChallengeCompletedScreen(
          key: const Key('challenge-completed'),
          challengeSummary: state.extra! as ChallengeSummaryEntity,
        ),
      ),
    ),
    GoRoute(
      path: ChallengeNoScoreScreen.routePath,
      pageBuilder: (context, state) => buildPageTransition(
        child: ChallengeNoScoreScreen(
          key: const Key('challenge-no-score'),
          challengeSummary: state.extra! as ChallengeSummaryEntity,
        ),
      ),
    ),
    GoRoute(
      path: OceanChallengeScreen.routePath,
      pageBuilder: (context, state) {
        return buildPageTransition<void>(
          child: GameWidget(game: OceanChallengeScreen()),
        );
      },
    ),
  ],
);
