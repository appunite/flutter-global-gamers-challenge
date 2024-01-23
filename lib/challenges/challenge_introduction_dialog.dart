import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/common/common_dialog.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/style/const_values.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class ChallengeIntroductionDialog extends StatelessWidget {
  const ChallengeIntroductionDialog({
    super.key,
    required this.challenge,
    required this.onButtonPressed,
  });

  final ChallengeType challenge;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              challenge.description,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Palette.secondaryDark,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          InstructionContainer(text: challenge.instruction1),
          const SizedBox(height: 12),
          InstructionContainer(text: challenge.instruction2),
          const SizedBox(height: 12),
          const SizedBox(height: 120),
        ],
      ),
      bottom: MainButton(
        onPressed: onButtonPressed,
        text: 'I\'m ready!',
      ),
      themeColor: Palette.secondaryDark,
      ribbon: RibbonHeader(
        customChild: Row(
          children: [
            Text(
              challenge.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Palette.secondaryDark,
                  ),
            ),
            const Icon(Icons.close),
          ],
        ),
      ),
    );
  }
}

class InstructionContainer extends StatelessWidget {
  const InstructionContainer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: borderRadius16,
        color: Palette.secondaryLight,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
