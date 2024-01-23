import 'dart:io';

import 'package:endless_runner/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:endless_runner/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:endless_runner/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:endless_runner/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:endless_runner/common/google_wallet_demo.dart';
import 'package:endless_runner/settings/settings_screen.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import '../style/wobbly_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: palette.backgroundMain.color,
      body: ResponsiveScreen(
        squarishMainArea: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WobblyButton(
                onPressed: () {
                  audioController.playSfx(SfxType.buttonTap);
                  context.go('/play');
                },
                child: const Text('Play'),
              ),
              gap10,
              WobblyButton(
                onPressed: () => context.push(PipesChallengeScreen.routePath),
                child: const Text('Fix pipes'),
              ),
              gap10,
              WobblyButton(
                onPressed: () => context.push(OceanChallengeScreen.routePath),
                child: const Text('Ocean shooter'),
              ),
              gap10,
              if (Platform.isAndroid)
                WobblyButton(
                  onPressed: () => context.push(GoogleWalletDemoScreen.routePath),
                  child: const Text('Google wallet'),
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
            WobblyButton(
              onPressed: () => context.push(SettingsScreen.routePath),
              child: const Text('Settings'),
            ),
            gap10,
            WobblyButton(
              onPressed: () => context.push(SolarPanelChallengeScreen.routePath),
              child: const Text('Solar panel scratcher'),
            ),
            gap10,
            WobblyButton(
              onPressed: () => context.push(RecyclingChallengeScreen.routePath),
              child: const Text('Recycling'),
            ),
            gap10,
            WobblyButton(
              onPressed: () => context.push(TreesChallengeScreen.routePath),
              child: const Text('Plant trees'),
            ),
          ],
        ),
      ),
    );
  }
}
