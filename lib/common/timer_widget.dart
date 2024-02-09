import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/time_helper.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    super.key,
    required this.timeInSeconds,
    this.countDown = false,
  });

  final int timeInSeconds;
  final bool countDown;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.neutralWhite,
        borderRadius: borderRadius32,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AssetPaths.iconTimer,
            height: 24,
            width: 24,
          ),
          gap8,
          Container(
            constraints: const BoxConstraints(minWidth: 75),
            alignment: Alignment.topCenter,
            height: 26,
            child: Text(
              timeInSeconds.formatTime(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: countDown
                        ? timeInSeconds < 6
                            ? Palette.error
                            : Palette.neutralBlack
                        : Palette.neutralBlack,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
