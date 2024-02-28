import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.controller,
    required this.progressAnimation,
  });

  final AnimationController controller;
  final Animation<double> progressAnimation;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
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
                SizedBox(
                  height: 36,
                  width: 300,
                  child: LiquidLinearProgressIndicator(
                    borderRadius: 24,
                    borderColor: Palette.neutralWhite,
                    backgroundColor: Palette.neutralWhite,
                    borderWidth: 4,
                    valueColor: const AlwaysStoppedAnimation<Color>(Palette.secondary),
                    value: widget.progressAnimation.value,
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
}
