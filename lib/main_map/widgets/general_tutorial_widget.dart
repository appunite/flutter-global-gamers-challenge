import 'package:better_world/common/eco_avatar.dart';
import 'package:better_world/main_map/tutorial/text_bubble_widget.dart';
import 'package:better_world/main_map/tutorial/eco_text_bubble_type.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
import 'package:flutter/material.dart';

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
        const EcoAvatar(),
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
