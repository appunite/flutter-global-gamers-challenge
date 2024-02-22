import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/back_button.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flutter/material.dart';

class AchievementsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AchievementsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        gap16,
        GameBackButton(),
        Spacer(),
        RibbonHeader(
          text: 'Achievements',
          ribbonImage: AssetPaths.ribbonYellow,
        ),
        Spacer(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
