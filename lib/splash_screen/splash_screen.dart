import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/main_menu/main_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routePath = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _preloadAnimations();
    Future.delayed(const Duration(seconds: 4), () {
      context.go(MainMapScreen.routePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: RiveAnimation.asset(
              AssetPaths.splashAnimation,
              animations: ['Cleaned World'],
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SizedBox(
              height: 168,
              width: 375,
              child: RiveAnimation.asset(AssetPaths.logoAnimation),
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
