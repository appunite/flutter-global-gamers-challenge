import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/back_button.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/style/const_values.dart';
import 'package:flutter/material.dart';

class AchievementsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AchievementsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const RibbonHeader(
          text: 'Achievements',
          ribbonImage: AssetPaths.ribbonYellow,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SafeArea(
            child: Padding(
              padding: displayAdditionalPadding ? const EdgeInsets.all(8) : EdgeInsets.zero,
              child: const GameBackButton(),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
