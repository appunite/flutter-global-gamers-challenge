import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/main_menu/tutorial/text_bubble_widget.dart';
import 'package:better_world/main_menu/tutorial/eco_text_bubble_type.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
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
            if (buttonVisible) ...[
              gap24,
              MainButton(
                text: 'Continue',
                width: 220,
                onPressed: (_) => onButtonPressed?.call(),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
