import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FinishedChallengeButtons extends StatelessWidget {
  const FinishedChallengeButtons({
    super.key,
    required this.challengeType,
  });

  final ChallengeType challengeType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MainButton.secondary(
          width: 170,
          text: 'Play Again',
          onPressed: (_) {
            context.go(challengeType.routePath);
          },
        ),
        gap12,
        MainButton(
          width: 160,
          text: 'Go to Map',
          onPressed: (_) => context.go('/'),
        ),
      ],
    );
  }
}
