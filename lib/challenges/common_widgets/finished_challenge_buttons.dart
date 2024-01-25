import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:flutter/material.dart';

class FinishedChallengeButtons extends StatelessWidget {
  const FinishedChallengeButtons({
    super.key,
    required this.onSecondaryButtonPressed,
    required this.onPrimaryButtonPressed,
  });

  final VoidCallback onSecondaryButtonPressed;
  final VoidCallback onPrimaryButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MainButton.secondary(
          width: 170,
          text: 'Play Again',
          onPressed: onSecondaryButtonPressed,
        ),
        gap12,
        MainButton(
          width: 160,
          text: 'Go to Map',
          onPressed: onPrimaryButtonPressed,
        ),
      ],
    );
  }
}
