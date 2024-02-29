import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/icon_button.dart';
import 'package:better_world/common/map_button.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/common/success_snack_bar.dart';
import 'package:better_world/leaderboard/achievements/achievements_screen.dart';
import 'package:better_world/leaderboard/leaderboard_controller.dart';
import 'package:better_world/leaderboard/widgets/leaderboard_list_tile.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/persistence/database_persistence.dart';
import 'package:better_world/player_progress/persistence/local_player_persistence.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({
    super.key,
    this.shouldDisplayChangedUsernameSnackBar = false,
  });

  static const String routePath = '/leaderboard';

  final bool shouldDisplayChangedUsernameSnackBar;

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _showSnackBar(context));
  }

  void _showSnackBar(BuildContext context) {
    if (widget.shouldDisplayChangedUsernameSnackBar) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBarBuilder(
          icon: SvgPicture.asset(
            AssetPaths.iconsCheckmark,
            height: 32,
            width: 32,
          ),
          title: 'Your username is saved!',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<LeaderboardController>(
      create: (context) => LeaderboardController(
        databaseStorage: context.read<DatabasePersistence>(),
        localStorage: context.read<LocalPlayerPersistence>(),
      ),
      child: Builder(
        builder: (context) => ValueListenableBuilder(
          valueListenable: context.read<LeaderboardController>().leaderboard,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 124),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    gap24,
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
                                            score: player.challengesScores.getAllChallengesScores(),
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
                                score: leaderboard.player.challengesScores.getAllChallengesScores(),
                                color: Palette.accentLight,
                              ),
                              gap32,
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: SafeArea(
                            child: Padding(
                              padding: displayAdditionalPadding ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GameIconButton(
                                    onTap: () => context.push(AchievementsScreen.routePath),
                                    iconName: AssetPaths.iconsBadges,
                                    width: 56,
                                    height: 56,
                                  ),
                                  gap16,
                                  const MapButton(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
