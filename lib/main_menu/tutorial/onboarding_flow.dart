import 'package:better_world/main_menu/tutorial/eco_text_bubble_type.dart';
import 'package:better_world/style/overlay_widget.dart';
import 'package:better_world/main_menu/tutorial_steps/challenge_tutorial_widget.dart';
import 'package:better_world/main_menu/tutorial_steps/general_tutorial_widget.dart';
import 'package:flutter/material.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _currentStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,
          _isFirstOrSecondStep() ? const OverlayWidget() : const ChallengeTutorialWidget(),
        ],
      ),
      floatingActionButton: _isFirstOrSecondStep()
          ? GeneralTutorialWidget(
              ecoTextBubbleType: EcoTextBubbleType.values[_currentStepIndex],
              buttonVisible: true,
              onButtonPressed: () {
                setState(() {
                  if (_currentStepIndex >= EcoTextBubbleType.values.length) {
                    return;
                  }
                  _currentStepIndex++;
                });
              },
            )
          : const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  bool _isFirstOrSecondStep() => _currentStepIndex == 0 || _currentStepIndex == 1;
}
