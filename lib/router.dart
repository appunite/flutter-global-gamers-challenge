import 'package:better_world/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:better_world/challenges/common_widgets/challenge_no_score_screen.dart';
import 'package:better_world/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:better_world/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:better_world/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:better_world/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:better_world/challenges/trees_challenge/challenge_summary_entity.dart';
import 'package:better_world/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:better_world/common/google_wallet_demo.dart';
import 'package:better_world/leaderboard/achievements/achievements_screen.dart';
import 'package:better_world/leaderboard/leaderboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'challenges/lights_out_challenge/lights_out_challenge_screen.dart';
import 'main_map/main_map_screen.dart';
import 'style/page_transition.dart';

final router = GoRouter(
  initialLocation: MainMapScreen.routePath,
  initialExtra: true,
  routes: [
    GoRoute(
      path: MainMapScreen.routePath,
      pageBuilder: (context, state) => buildPageTransition<void>(
        key: const ValueKey('main-map'),
        child: MainMapScreen(isAppLauch: state.extra as bool?),
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
      pageBuilder: (context, state) => buildPageTransition(
        child: LeaderboardScreen(
          key: const Key('leaderboard'),
          shouldDisplayChangedUsernameSnackBar: state.extra! as bool,
        ),
      ),
    ),
    GoRoute(
      path: AchievementsScreen.routePath,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 200),
        child: const AchievementsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeIn)).animate(animation),
            child: child,
          );
        },
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
          child: const OceanChallengeScreen(),
        );
      },
    ),
  ],
);
