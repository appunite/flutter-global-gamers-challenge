import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/common_dialog.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChallengeExitDialog extends StatelessWidget {
  const ChallengeExitDialog({
    super.key,
    required this.onButtonPressed,
  });

  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Are you sure you want to exit? Your progress in this challenge will not be saved.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Palette.neutralBlack,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      bottom: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainButton.secondary(
            width: 120,
            onPressed: (_) => context
              ..pop()
              ..pop(),
            text: 'Exit',
          ),
          gap12,
          MainButton(
            width: 215,
            onPressed: (_) => onButtonPressed(),
            text: 'Continue Game',
          ),
        ],
      ),
      themeColor: Palette.secondaryDark,
      ribbon: const RibbonHeader(
        text: 'Exit Challenge',
      ),
      ecoImage: AssetPaths.ecoClose,
    );
  }
}
