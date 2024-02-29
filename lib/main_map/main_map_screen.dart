import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/icon_button.dart';
import 'package:better_world/common/navigation_helper.dart';
import 'package:better_world/common/game_progress_indicator.dart';
import 'package:better_world/common/points_counter.dart';
import 'package:better_world/leaderboard/leaderboard_screen.dart';
import 'package:better_world/main_map/game_completed_congrats_widget.dart';
import 'package:better_world/main_map/map_animation.dart';
import 'package:better_world/main_map/tutorial/onboarding_flow.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/settings/settings_dialog.dart';
import 'package:better_world/splash_screen/splash_screen.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../style/palette.dart';

class MainMapScreen extends StatefulWidget {
  const MainMapScreen({super.key, this.isAppLauch});

  static const String routePath = '/';

  final bool? isAppLauch;

  @override
  State<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> with SingleTickerProviderStateMixin {
  bool _shouldShowAllChallengesCongrats = false;
  bool _hasSeenOnboarding = true;
  bool _splashScreenVisibile = true;

  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _setAnimationController();

    final playerProgressController = context.read<PlayerProgressController>();
    playerProgressController.addListener(() {
      setState(() {
        _shouldShowAllChallengesCongrats = playerProgressController.shouldShowAllChallengesCongrats;
        _hasSeenOnboarding = playerProgressController.hasSeenOnboarding;
      });
    });

    WakelockPlus.enable();
  }

  void _setAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _progressAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _splashScreenVisibile = false;
      }
      setState(() {});
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final playerProgressController = context.watch<PlayerProgressController>();

    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const GameProgressIndicator(),
                  gap30,
                  PointsCounter(pointsCount: playerProgressController.challenges.getAllChallengesScores()),
                ],
              ),
            ),
            backgroundColor: Palette.secondaryLight,
            body: _buildBody()),
        Visibility(
          visible: _shouldDisplaySplash(),
          child: SplashScreen(
            controller: _controller,
            progressAnimation: _progressAnimation,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        const MapAnimation(),
        Visibility(
          visible: _shouldShowAllChallengesCongrats,
          child: const GameCompletedCongratsWidget(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SafeArea(
            child: Padding(
              padding: displayAdditionalPadding ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
              child: GameIconButton(
                iconName: AssetPaths.leaderboard,
                width: 56,
                height: 56,
                onTap: () => context.push(LeaderboardScreen.routePath, extra: false),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
            child: Padding(
              padding: displayAdditionalPadding ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
              child: GameIconButton(
                iconName: AssetPaths.settings,
                width: 56,
                height: 56,
                onTap: () => NavigationHelper.show(
                  context,
                  const SettingsDialog(),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !_hasSeenOnboarding,
          child: const OnboardingFlow(),
        ),
      ],
    );
  }

  bool _shouldDisplaySplash() => (widget.isAppLauch ?? false) && _splashScreenVisibile;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
