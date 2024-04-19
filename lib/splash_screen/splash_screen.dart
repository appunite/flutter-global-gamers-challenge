import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/progress_bar_animation.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.progressAnimation,
  });

  final Animation<double> progressAnimation;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _preloadAnimations();
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
                ProgressBarAnimation(progressAnimation: widget.progressAnimation),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _preloadAnimations() {
    rootBundle.load(AssetPaths.pipesBackground);
  }
}
