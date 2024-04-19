import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/main_map/tutorial/eco_text_bubble_type.dart';
import 'package:better_world/main_map/widgets/general_tutorial_widget.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/overlay_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({
    super.key,
  });

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _currentStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: const OverlayWidget(),
      floatingActionButton: GeneralTutorialWidget(
        ecoTextBubbleType: EcoTextBubbleType.values[_currentStepIndex],
        buttonVisible: true,
        onButtonPressed: () {
          if (kIsWeb && _currentStepIndex == 0) {
            context.read<AudioController>().playCurrentSongInPlaylist();
          }
          if (_currentStepIndex >= EcoTextBubbleType.values.length) {
            return;
          }
          if (_currentStepIndex == EcoTextBubbleType.values.length - 2) {
            context.read<PlayerProgressController>().setHasSeenOnboarding();
            return;
          }
          setState(() {
            _currentStepIndex++;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
