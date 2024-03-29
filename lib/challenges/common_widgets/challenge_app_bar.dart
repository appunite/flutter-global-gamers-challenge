import 'package:better_world/common/points_counter.dart';
import 'package:better_world/common/timer_widget.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flutter/material.dart';

class ChallengeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChallengeAppBar({
    super.key,
    this.score,
    required this.timeInSeconds,
    required this.countDown,
    this.actions,
  });

  final int? score;
  final int timeInSeconds;
  final bool countDown;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (score != null) ...[
            PointsCounter(pointsCount: score!),
            gap16,
          ],
          TimerWidget(
            timeInSeconds: timeInSeconds,
            countDown: countDown,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
