import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/common_dialog.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExitChallengeDialog extends StatelessWidget {
  const ExitChallengeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Are you sure you want to exit?\nYour progress in this challenge will not be saved.',
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
            width: 150,
            onPressed: (_) => context.go('/'), //TODO(Kostrzewsky): Move player to the map
            text: 'Yes, Exit',
          ),
          gap12,
          MainButton(
            width: 170,
            onPressed: (_) => context.pop(),
            text: 'Continue Game',
          ),
        ],
      ),
      themeColor: Palette.error,
      ribbon: const RibbonHeader(
        ribbonImage: AssetPaths.ribbonBlue,
        text: 'Exit Challenge',
      ),
      ecoImage: AssetPaths.ecoClose,
    );
  }
}
