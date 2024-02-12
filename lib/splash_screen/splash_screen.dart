import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/main_menu/main_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    Future.delayed(const Duration(seconds: 3), () {
      context.go(MainMapScreen.routePath);
    });
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
            child: SizedBox(
              height: 168,
              width: 375,
              child: SvgPicture.asset(AssetPaths.logo),
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
