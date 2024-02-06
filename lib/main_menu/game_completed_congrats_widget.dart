import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/main_menu/tutorial/eco_text_bubble_type.dart';
import 'package:endless_runner/main_menu/tutorial_steps/general_tutorial_widget.dart';
import 'package:endless_runner/player_progress/player_progress_controller.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GameCompletedCongratsWidget extends StatelessWidget {
  const GameCompletedCongratsWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final playerProgressController = context.watch<PlayerProgressController>();

    return Stack(
      children: [
        child,
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
          onTap: () => playerProgressController.setHasSeenCongrats(),
          child: const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
        )
      ],
    );
  }
}
