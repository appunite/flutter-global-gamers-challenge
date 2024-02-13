import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/main_menu/tutorial/eco_text_bubble_type.dart';
import 'package:better_world/main_menu/widgets/general_tutorial_widget.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GameCompletedCongratsWidget extends StatefulWidget {
  const GameCompletedCongratsWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GameCompletedCongratsWidget> createState() => _GameCompletedCongratsWidgetState();
}

class _GameCompletedCongratsWidgetState extends State<GameCompletedCongratsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AudioController>().playSfx(SfxType.fireworks);
  }

  @override
  Widget build(BuildContext context) {
    final playerProgressController = context.watch<PlayerProgressController>();

    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.topCenter,
          child: Lottie.asset(AssetPaths.fireworks, repeat: true),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const GeneralTutorialWidget(
                  ecoTextBubbleType: EcoTextBubbleType.allChallengesCompleted,
                  buttonVisible: false,
                ),
                Text(
                  'Tap anywhere to continue'.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Palette.neutralWhite,
                      ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            playerProgressController.setHasSeenCongrats();
            context.read<AudioController>().stopSfx();
          },
          child: const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
