import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/challenges/pipes_challenge/pipes_controller.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class PipeStraight extends StatelessWidget {
  const PipeStraight({
    super.key,
    required this.angle,
  });

  final double angle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: SvgPicture.asset(
        AssetPaths.pipeStraight,
      ),
    );
  }
}

class PipeCorner extends StatelessWidget {
  const PipeCorner({
    super.key,
    required this.angle,
    required this.lastPipe,
  });

  final double angle;
  final bool lastPipe;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: SvgPicture.asset(
        lastPipe ? AssetPaths.pipeEnd : AssetPaths.pipeCorner,
      ),
    );
  }
}

class PipeEmpty extends StatelessWidget {
  const PipeEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return gap30;
  }
}

class PipeWheel extends StatefulWidget {
  const PipeWheel({super.key});

  @override
  State<PipeWheel> createState() => _PipeWheelState();
}

class _PipeWheelState extends State<PipeWheel> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setControllers();

    final pipesController = context.read<PipesController>();
    pipesController.addListener(() {
      if (pipesController.challengeCompleted) {
        _rotationController.forward();
        _scaleController.forward();
        context.read<AudioController>().playSfx(SfxType.pipeWheel);
      }
    });
  }

  void _setControllers() {
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );

    _rotationController.addListener(() {
      setState(() {});
    });

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _scaleController.addListener(() {
      setState(() {});
      if (_scaleController.isCompleted) {
        _scaleController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 69,
      height: 69,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AssetPaths.pipeStart,
          ),
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: SvgPicture.asset(
                AssetPaths.wheel,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}
