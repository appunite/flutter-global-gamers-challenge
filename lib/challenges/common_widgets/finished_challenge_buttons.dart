import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/leaderboard/introduction/leaderboard_introduction_dialog.dart';
import 'package:better_world/main_map/main_map_screen.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FinishedChallengeButtons extends StatefulWidget {
  const FinishedChallengeButtons({
    super.key,
    required this.challengeType,
  });

  final ChallengeType challengeType;

  @override
  State<FinishedChallengeButtons> createState() => _FinishedChallengeButtonsState();
}

class _FinishedChallengeButtonsState extends State<FinishedChallengeButtons> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainButton.secondary(
            width: 170,
            text: 'Play Again',
            onPressed: (_) {
              final playerProgress = context.read<PlayerProgressController>();
              playerProgress.loadPlayerData();
              context.go(widget.challengeType.routePath);
            },
          ),
          gap12,
          MainButton(
            width: 170,
            text: 'Go to Map',
            isLoading: _isPressed,
            onPressed: (_) {
              if (!_isPressed) {
                final playerProgress = context.read<PlayerProgressController>();
                playerProgress.loadPlayerData();

                if (playerProgress.challenges.getPlayedChallengesCount() == 0) {
                  NavigationHelper.show(
                    context,
                    const LeaderboardIntroductionDialog(shouldGoToLeaderBoardScreen: true),
                  );
                } else {
                  Future.delayed(const Duration(seconds: 1), () {
                    context.go(MainMapScreen.routePath);
                  });
                }
              }
              setState(() {
                _isPressed = true;
              });
            },
          ),
        ],
      ),
    );
  }
}
