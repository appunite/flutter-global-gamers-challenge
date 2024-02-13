import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/settings/reset_account_dialog.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ResetSettingsRow extends StatelessWidget {
  const ResetSettingsRow({super.key});

  @override
  Widget build(BuildContext context) {
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
          Text(
            'Reset game',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Palette.neutralBlack),
          ),
          const Spacer(),
          MainButton.secondary(
            width: 100,
            onPressed: (_) {
              context.pop();
              NavigationHelper.show(
                context,
                const ResetAccountDialog(),
              );
            },
            text: 'Reset',
          ),
        ],
      ),
    );
  }
}
