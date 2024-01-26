import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/player_progress/entities/challenges_entity.dart';
import 'package:endless_runner/player_progress/player_progress_controller.dart';
import 'package:endless_runner/style/const_values.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

class GameProgressIndicator extends StatelessWidget {
  const GameProgressIndicator({super.key});

  static const _numberOfChallenges = 6;

  @override
  Widget build(BuildContext context) {
    final playerProgress = context.watch<PlayerProgressController>();

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 6, 8, 6),
      decoration: BoxDecoration(
        color: Palette.neutralWhite,
        borderRadius: borderRadius32,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AssetPaths.iconsMap,
            height: 24,
            width: 24,
          ),
          gap12,
          SizedBox(
            width: 100,
            height: 30,
            child: LiquidLinearProgressIndicator(
              borderColor: Colors.transparent,
              borderWidth: 0,
              borderRadius: 32,
              value: _getPlayedChallengesCount(playerProgress) / _numberOfChallenges,
              center: Text(
                '${_getPlayedChallengesCount(playerProgress)}/$_numberOfChallenges',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Palette.neutralBlack,
                    ),
              ),
              valueColor: const AlwaysStoppedAnimation(Palette.primaryProgress),
              backgroundColor: Palette.neutralLightGray,
            ),
          )
        ],
      ),
    );
  }

  int _getPlayedChallengesCount(PlayerProgressController playerProgress) =>
      playerProgress.challenges.getPlayedChallengesCount();
}
