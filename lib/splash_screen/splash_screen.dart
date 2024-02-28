import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/main_map/main_map_screen.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routePath = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _preloadAnimations();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _progressAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.addListener(() {
      if (_controller.isCompleted) {
        context.go(MainMapScreen.routePath);
      }
      setState(() {});
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: RiveAnimation.asset(
              AssetPaths.splashAnimation,
              animations: ['Cleaned World'],
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 168,
                  width: 375,
                  child: RiveAnimation.asset(AssetPaths.logoAnimation),
                ),
                gap8,
                SizedBox(
                  height: 36,
                  width: 300,
                  child: LiquidLinearProgressIndicator(
                    borderRadius: 24,
                    borderColor: Palette.neutralWhite,
                    backgroundColor: Palette.neutralWhite,
                    borderWidth: 4,
                    valueColor: const AlwaysStoppedAnimation<Color>(Palette.secondary),
                    value: _progressAnimation.value,
                    center: Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Palette.neutralWhite,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _preloadAnimations() {
    rootBundle.load(AssetPaths.pipesBackground);
    //TODO add map animation here
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
