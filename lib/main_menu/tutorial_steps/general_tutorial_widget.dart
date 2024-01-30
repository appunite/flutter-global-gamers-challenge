import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/main_menu/tutorial/text_bubble_widget.dart';
import 'package:endless_runner/main_menu/tutorial/tutorial_step_enum.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GeneralTutorialWidget extends StatelessWidget {
  const GeneralTutorialWidget({
    super.key,
    required this.ecoTextBubbleType,
    this.buttonVisible = true,
    this.onButtonPressed,
  });

  final EcoTextBubbleType ecoTextBubbleType;
  final bool buttonVisible;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 100,
          width: 100,
          child: RiveAnimation.asset(
            AssetPaths.ecoAnimation,
            animations: ['Blinking'],
            artboard: 'Eco',
            stateMachines: ['StateMachine'],
          ),
        ),
        gap4,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBubbleWidget(
              textBubbleType: ecoTextBubbleType,
            ),
            gap24,
            if (buttonVisible)
              MainButton(
                text: 'Continue',
                width: 220,
                onPressed: (_) => onButtonPressed?.call(),
              ),
          ],
        ),
      ],
    );
  }
}
