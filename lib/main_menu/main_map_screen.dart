import 'package:better_world/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:better_world/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:better_world/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:better_world/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:better_world/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/common/game_progress_indicator.dart';
import 'package:better_world/common/points_counter.dart';
import 'package:better_world/challenges/lights_out_challenge/lights_out_challenge_screen.dart';
import 'package:better_world/leaderboard/leaderboard_screen.dart';
import 'package:better_world/main_menu/game_completed_congrats_widget.dart';
import 'package:better_world/main_menu/tutorial/onboarding_flow.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/settings/settings_dialog.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../settings/settings.dart';
import '../style/main_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMapScreen extends StatefulWidget {
  const MainMapScreen({super.key});

  static const String routePath = '/';

  @override
  State<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
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
              ? GameCompletedCongratsWidget(child: _buildBody(context, audioController, settingsController))
              : _buildBody(context, audioController, settingsController)
          : OnboardingFlow(
              child: _buildBody(context, audioController, settingsController),
            ),
    );
  }

  ResponsiveScreen _buildBody(
    BuildContext context,
    AudioController audioController,
    SettingsController settingsController,
  ) {
    return ResponsiveScreen(
      squarishMainArea: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainButton(
              onPressed: (_) {
                context.push(LightsOutChallengeScreen.routePath);
              },
              text: 'Play',
              width: 300,
            ),
            gap10,
            MainButton(
              onPressed: (Offset? offset) => context.push(
                PipesChallengeScreen.routePath,
                extra: offset,
              ),
              text: 'Fix pipes',
            ),
            gap10,
            MainButton(
              onPressed: (Offset? offset) => context.push(
                RecyclingChallengeScreen.routePath,
                extra: offset,
              ),
              text: 'Recycling',
            ),
            gap10,
            MainButton(
              onPressed: (_) => context.push(OceanChallengeScreen.routePath),
              text: 'Ocean shooter',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ValueListenableBuilder<bool>(
                valueListenable: settingsController.audioOn,
                builder: (context, audioOn, child) {
                  return IconButton(
                    onPressed: () => settingsController.toggleAudioOn(),
                    icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      rectangularMenuArea: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainButton.secondary(
            onPressed: (_) => NavigationHelper.show(context, const SettingsDialog()),
            text: 'Settings',
          ),
          gap10,
          MainButton.secondary(
            onPressed: (_) => context.push(SolarPanelChallengeScreen.routePath),
            text: 'Solar panel scratcher',
          ),
          gap10,
          MainButton.secondary(
            onPressed: (Offset? offset) => context.push(
              TreesChallengeScreen.routePath,
              extra: offset,
            ),
            text: 'Plant trees',
          ),
          gap10,
          MainButton.secondary(
            onPressed: (_) => context.push(LeaderboardScreen.routePath, extra: false),
            text: 'Leaderboard',
          ),
        ],
      ),
    );
  }
}
