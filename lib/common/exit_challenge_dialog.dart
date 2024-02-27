import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/common_dialog.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/main_menu/main_map_screen.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExitChallengeDialog extends StatelessWidget {
  const ExitChallengeDialog({
    super.key,
    this.onContinue,
  });

  final VoidCallback? onContinue;

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
            onPressed: (_) => context.go(MainMapScreen.routePath),
            text: 'Exit',
          ),
          gap12,
          MainButton(
            width: 220,
            onPressed: (_) {
              if (onContinue != null) {
                onContinue!.call();
              } else {
                context.pop();
              }
            },
            text: 'Continue Game',
          ),
        ],
      ),
      themeColor: Palette.secondaryDark,
      ribbon: const RibbonHeader(
        ribbonImage: AssetPaths.ribbonBlue,
        text: 'Exit Challenge',
      ),
      ecoImage: AssetPaths.ecoClose,
    );
  }
}
