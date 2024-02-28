import 'dart:io';

import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/icon_button.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/common/game_progress_indicator.dart';
import 'package:better_world/common/points_counter.dart';
import 'package:better_world/leaderboard/leaderboard_screen.dart';
import 'package:better_world/main_map/game_completed_congrats_widget.dart';
import 'package:better_world/main_map/map_animation.dart';
import 'package:better_world/main_map/tutorial/onboarding_flow.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/settings/settings_dialog.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';

class MainMapScreen extends StatefulWidget {
  const MainMapScreen({super.key});

  static const String routePath = '/';

  @override
  State<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
  @override
  Widget build(BuildContext context) {
    final playerProgressController = context.watch<PlayerProgressController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const GameProgressIndicator(),
            gap40,
            PointsCounter(pointsCount: playerProgressController.challenges.getAllChallengesScores()),
          ],
        ),
      ),
      backgroundColor: Palette.neutralDarkGray,
      body: playerProgressController.hasSeenOnboarding
          ? playerProgressController.shouldShowAllChallengesCongrats
              ? GameCompletedCongratsWidget(child: _buildBody())
              : _buildBody()
          : OnboardingFlow(
              child: _buildBody(),
            ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        const MapAnimation(),
        Align(
          alignment: Alignment.bottomLeft,
          child: SafeArea(
            child: Padding(
              padding: Platform.isAndroid ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
              child: GameIconButton(
                iconName: AssetPaths.leaderboard,
                width: 56,
                height: 56,
                onTap: () => context.push(LeaderboardScreen.routePath, extra: false),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
            child: Padding(
              padding: Platform.isAndroid ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
              child: GameIconButton(
                iconName: AssetPaths.settings,
                width: 56,
                height: 56,
                onTap: () => NavigationHelper.show(
                  context,
                  const SettingsDialog(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
