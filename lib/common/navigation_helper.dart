import 'package:better_world/challenges/common_widgets/challenge_completed_screen.dart';
import 'package:better_world/challenges/common_widgets/challenge_no_score_screen.dart';
import 'package:better_world/challenges/trees_challenge/challenge_summary_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  static void showWithWidgetBinding(BuildContext context, Widget widget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => widget,
      );
    });
  }

  static Future<void> show(BuildContext context, Widget widget) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => widget,
    );
  }

  static void navigateToChallengeResultScreen(
    BuildContext context,
    ChallengeSummaryEntity challengeSummary,
  ) {
    context.go(
      challengeSummary.score > 0 ? ChallengeCompletedScreen.routePath : ChallengeNoScoreScreen.routePath,
      extra: challengeSummary,
    );
  }
}
