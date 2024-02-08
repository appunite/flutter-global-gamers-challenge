import 'package:better_world/main_menu/tutorial/eco_text_bubble_type.dart';
import 'package:better_world/main_menu/tutorial_steps/general_tutorial_widget.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:overlay_tutorial/overlay_tutorial.dart';
import 'package:provider/provider.dart';

class ChallengeTutorialWidget extends StatelessWidget {
  const ChallengeTutorialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlayTutorialScope(
      overlayColor: Palette.overlay,
      enabled: true,
      child: OverlayTutorialHole(
        overlayTutorialEntry: OverlayTutorialCircleEntry(
          radius: 44,
          overlayTutorialHints: [
            OverlayTutorialWidgetHint(
              builder: (context, entryRect) => const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: GeneralTutorialWidget(
                    ecoTextBubbleType: EcoTextBubbleType.challengeIntroduction,
                    buttonVisible: false,
                  ),
                ),
              ),
            ),
          ],
        ),
        enabled: true,
        //TODO change to pin on the map
        child: GestureDetector(
          onTap: () {
            context.read<PlayerProgressController>().setHasSeenOnboarding();
          },
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 30,
              height: 30,
              color: Colors.pink,
            ),
          ),
        ),
      ),
    );
  }
}
