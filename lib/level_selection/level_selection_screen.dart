import 'package:endless_runner/style/main_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import 'levels.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    final levelTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4);

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection.color,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select level',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 16),
                  MainButton(
                    text: 'Button text',
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: SizedBox(
              width: 450,
              child: ListView(
                children: [
                  for (final level in gameLevels)
                    ListTile(
                      enabled: playerProgress.levels.length >= level.number - 1,
                      onTap: () {
                        final audioController = context.read<AudioController>();
                        audioController.playSfx(SfxType.buttonTap);

                        GoRouter.of(context).go('/play/session/${level.number}');
                      },
                      leading: Text(
                        level.number.toString(),
                        style: levelTextStyle,
                      ),
                      title: Row(
                        children: [
                          Text(
                            'Level #${level.number}',
                            style: levelTextStyle,
                          ),
                          if (playerProgress.levels.length < level.number - 1) ...[
                            const SizedBox(width: 10),
                            const Icon(Icons.lock, size: 20),
                          ] else if (playerProgress.levels.length >= level.number) ...[
                            const SizedBox(width: 50),
                            Text(
                              '${playerProgress.levels[level.number - 1]}s',
                              style: levelTextStyle,
                            ),
                          ],
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
