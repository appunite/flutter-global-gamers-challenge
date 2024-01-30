import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/dialog_helper.dart';
import 'package:endless_runner/common/icon_button.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/leaderboard/introduction/leaderboard_introduction_dialog.dart';
import 'package:endless_runner/leaderboard/leaderboard_controller.dart';
import 'package:endless_runner/leaderboard/widgets/leaderboard_list_tile.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  static const String routePath = '/leaderboard';

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    _showIntroDialog();
  }

  Future<void> _showIntroDialog() async {
    DialogHelper.showWithWidgetBinding(
      context,
      const LeaderboardIntroductionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leaderboardController = context.watch<LeaderboardController>();

    return ValueListenableBuilder(
      valueListenable: leaderboardController.leaderboard,
      builder: (context, leaderboard, child) {
        return Scaffold(
          backgroundColor: Palette.accent,
          body: leaderboard == null
              //TODO(kostrzewski): Create fun animation widget
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    const Positioned(
                      top: 32,
                      right: 16,
                      child: GameIconButton(
                        iconName: AssetPaths.iconsInfo,
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 124),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                gap32,
                                const RibbonHeader(
                                  text: 'Leaderboard',
                                  ribbonImage: AssetPaths.ribbonYellow,
                                ),
                                gap18,
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: leaderboard.players.length,
                                    separatorBuilder: (_, __) => gap8,
                                    itemBuilder: (context, int index) {
                                      final player = leaderboard.players[index];

                                      return LeaderboardListTile(
                                        index: index + 1,
                                        username: player.nick,
                                        score: player.getAllChallengesScores(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          gap8,
                          LeaderboardListTile(
                            index: leaderboard.players.indexWhere((player) => player == leaderboard.player) + 1,
                            username: leaderboard.player.nick,
                            score: leaderboard.player.getAllChallengesScores(),
                            color: Palette.accentLight,
                          ),
                          gap32,
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 32,
                      left: 24,
                      child: GameIconButton(
                        onTap: () => context.pop(),
                        iconName: AssetPaths.iconsMap,
                        width: 56,
                        height: 56,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
