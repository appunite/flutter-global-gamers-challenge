import 'package:better_world/change_player_name/set_player_name_dialog.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserNameSettingsRow extends StatelessWidget {
  const UserNameSettingsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.watch<PlayerProgressController>();

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: borderRadius16,
        color: Palette.secondaryLight,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AssetPaths.iconsProfile,
            height: 24,
            width: 24,
          ),
          gap8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Username',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Palette.neutralBlack),
              ),
              Text(
                player.playerNick,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const Spacer(),
          MainButton.secondary(
            width: 80,
            onPressed: (_) {
              context.pop();
              NavigationHelper.show(
                context,
                const SetPlayerNameDialog(shouldGoToLeaderBoardScreen: false),
              );
            },
            text: 'Edit',
          ),
        ],
      ),
    );
  }
}
