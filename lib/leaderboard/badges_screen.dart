import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';

import '../common/back_button.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  static const String routePath = '/badges';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Palette.accent,
      body: Stack(
        children: [
          Positioned(
            top: 32,
            left: 16,
            child: GameBackButton(),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                gap24,
                RibbonHeader(
                  text: 'Achievements',
                  ribbonImage: AssetPaths.ribbonYellow,
                ),
                gap18,
              ],
            ),
          )
        ],
      ),
    );
  }
}
