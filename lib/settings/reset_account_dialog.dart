import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/common_dialog.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/common/success_snack_bar.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ResetAccountDialog extends StatelessWidget {
  const ResetAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProgressController = context.watch<PlayerProgressController>();

    return CommonDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'You can reset your game progress and begin a new game. This will erase all your scores and achievements and cannot be undone.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Palette.neutralBlack,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      bottom: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TODO check if it resets correctly the map
          MainButton.secondary(
            width: 150,
            onPressed: (_) {
              playerProgressController.reset().then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBarBuilder(
                    icon: SvgPicture.asset(
                      AssetPaths.iconsCheckmark,
                      height: 32,
                      width: 32,
                    ),
                    title: 'Your progress has been reset!',
                  ),
                );
                context.pop();
              });
            },
            text: 'Reset',
          ),
          gap12,
          MainButton(
            width: 150,
            onPressed: (_) => context.pop(),
            text: 'Cancel',
          ),
        ],
      ),
      themeColor: Palette.secondaryDark,
      ribbon: const RibbonHeader(
        ribbonImage: AssetPaths.ribbonBlue,
        text: 'Reset Your Progress?',
      ),
      ecoImage: AssetPaths.ecoClose,
    );
  }
}
