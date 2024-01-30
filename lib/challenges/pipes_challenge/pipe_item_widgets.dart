import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      width: 60,
      height: 60,
      child: SvgPicture.asset(
        AssetPaths.pipeStraight,
        fit: BoxFit.contain,
      ),
    );
  }
}

class PipeCorner extends StatelessWidget {
  const PipeCorner({
    super.key,
    required this.angle,
  });

  final double angle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: SvgPicture.asset(
        AssetPaths.pipeCorner,
        fit: BoxFit.scaleDown,
        alignment: angle == 0.0
            ? Alignment.bottomLeft
            : angle == math.pi / 2
                ? Alignment.bottomLeft
                : Alignment.bottomLeft,
      ),
    );
  }
}

class PipeEmpty extends StatelessWidget {
  const PipeEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return gap60;
  }
}

class PipeWheel extends StatelessWidget {
  const PipeWheel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: SvgPicture.asset(
        AssetPaths.pipeWheel,
        fit: BoxFit.contain,
      ),
    );
  }
}
