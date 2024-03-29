import 'package:better_world/challenges/common_widgets/introduction_container.dart';
import 'package:better_world/change_player_name/set_player_name_dialog.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/common_dialog.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeaderboardIntroductionDialog extends StatelessWidget {
  const LeaderboardIntroductionDialog({
    super.key,
    required this.shouldGoToLeaderBoardScreen,
  });

  final bool shouldGoToLeaderBoardScreen;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gap24,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              'Track your journey on improving Better World! Climb the Leaderboard!',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Palette.neutralBlack,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          gap12,
          const InstructionContainer(
            text: 'Earn points by completing challenges faster.',
            color: Palette.accentLight,
            assetPath: AssetPaths.infoLeaderboard1,
          ),
          gap12,
          const InstructionContainer(
            text: 'Replay challenges to beat your score and rank higher.',
            color: Palette.accentLight,
            assetPath: AssetPaths.infoLeaderboard2,
          ),
          gap12,
        ],
      ),
      bottom: MainButton(
        onPressed: (_) {
          context.pop();
          _showSetPlayerNameDialog(context);
        },
        text: 'Continue',
        width: 180,
      ),
      themeColor: Palette.accentDark,
      ribbon: RibbonHeader(
        ribbonImage: AssetPaths.ribbonYellow,
        text: 'Leaderboard',
        withCloseIcon: true,
        onCloseTap: () => context.pop(),
      ),
      ecoImage: AssetPaths.ecoLeaderboard,
    );
  }

  void _showSetPlayerNameDialog(BuildContext context) {
    NavigationHelper.showWithWidgetBinding(
      context,
      SetPlayerNameDialog(shouldGoToLeaderBoardScreen: shouldGoToLeaderBoardScreen),
    );
  }
}
