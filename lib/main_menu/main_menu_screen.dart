import 'package:endless_runner/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:endless_runner/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:endless_runner/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:endless_runner/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:endless_runner/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:endless_runner/common/dialog_helper.dart';
import 'package:endless_runner/main_menu/tutorial/onboarding_flow.dart';
import 'package:endless_runner/player_progress/player_progress_controller.dart';
import 'package:endless_runner/settings/settings_dialog.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import '../style/main_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();
    final playerProgressController = context.watch<PlayerProgressController>();

    return Scaffold(
      backgroundColor: Palette.secondary,
      body: playerProgressController.hasSeenOnboarding
          ? _buildBody(audioController, context, settingsController)
          : OnboardingFlow(
              child: _buildBody(audioController, context, settingsController),
            ),
    );
  }

  ResponsiveScreen _buildBody(
      AudioController audioController, BuildContext context, SettingsController settingsController) {
    return ResponsiveScreen(
      squarishMainArea: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonTap);
                context.go('/play');
              },
              text: 'Play',
            ),
            gap10,
            MainButton(
              onPressed: () => context.push(PipesChallengeScreen.routePath),
              text: 'Fix pipes',
            ),
            gap10,
            MainButton(
              onPressed: () => context.push(ChallengeCompletedScreen.routePath),
              text: 'Completed challenge',
            ),
            gap10,
            MainButton(
              onPressed: () => context.push(OceanChallengeScreen.routePath),
              text: 'Ocean shooter',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
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
            onPressed: () => DialogHelper.show(context, const SettingsDialog()),
            text: 'Settings',
          ),
          gap10,
          MainButton.secondary(
            onPressed: () => context.push(SolarPanelChallengeScreen.routePath),
            text: 'Solar panel scratcher',
          ),
          gap10,
          MainButton.secondary(
            onPressed: () => context.push(RecyclingChallengeScreen.routePath),
            text: 'Recycling',
          ),
          gap10,
          MainButton.secondary(
            onPressed: () => context.push(TreesChallengeScreen.routePath),
            text: 'Plant trees',
          ),
        ],
      ),
    );
  }
}
