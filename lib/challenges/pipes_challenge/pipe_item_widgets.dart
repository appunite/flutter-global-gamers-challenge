import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/style/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  });

  final double angle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: SvgPicture.asset(
        AssetPaths.pipeCorner,
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

class PipeWheel extends StatelessWidget {
  const PipeWheel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 69,
      height: 69,
      child: SvgPicture.asset(
        AssetPaths.pipeWheel,
      ),
    );
  }
}
