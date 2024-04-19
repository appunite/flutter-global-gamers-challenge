import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/eco_avatar.dart';
import 'package:better_world/common/progress_bar_animation.dart';
import 'package:better_world/style/overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MapLoadingWidget extends StatefulWidget {
  const MapLoadingWidget({
    super.key,
  });

  @override
  State<MapLoadingWidget> createState() => _MapLoadingWidgetState();
}

class _MapLoadingWidgetState extends State<MapLoadingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _setAnimationController();
  }

  void _setAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _progressAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(
          height: double.infinity,
          width: double.infinity,
        ),
        const Positioned.fill(
          child: RiveAnimation.asset(
            AssetPaths.splashAnimation,
            animations: ['Cleaned World'],
            fit: BoxFit.cover,
          ),
        ),
        const OverlayWidget(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EcoAvatar(),
            const SizedBox(height: 24),
            ProgressBarAnimation(progressAnimation: _progressAnimation),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
