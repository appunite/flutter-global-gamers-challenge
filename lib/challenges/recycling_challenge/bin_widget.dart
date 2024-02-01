import 'package:endless_runner/audio/audio_controller.dart';
import 'package:endless_runner/audio/sounds.dart';
import 'package:endless_runner/challenges/recycling_challenge/garbage_controller.dart';
import 'package:endless_runner/challenges/recycling_challenge/garbage_type_enum.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

enum BinType {
  paper(assetPath: AssetPaths.binBlue),
  glass(assetPath: AssetPaths.binGreen),
  plasticMetal(assetPath: AssetPaths.binYellow),
  organic(assetPath: AssetPaths.binBlack);

  const BinType({required this.assetPath});

  final String assetPath;
}

class BinWidget extends StatefulWidget {
  const BinWidget({
    super.key,
    required this.dumpsterType,
  });

  final BinType dumpsterType;

  @override
  State<BinWidget> createState() => _BinWidgetState();
}

class _BinWidgetState extends State<BinWidget> {
  bool _animationPlaying = false;

  @override
  Widget build(BuildContext context) {
    final garbageController = context.watch<GarbageController>();
    final audioController = context.watch<AudioController>();

    return DragTarget<GarbageType>(
      onWillAccept: (data) => data?.dumpsterType == widget.dumpsterType,
      onAccept: (data) {
        garbageController.itemSorted(data);
        audioController.playSfx(SfxType.garbage);

        setState(() {
          _animationPlaying = true;
        });
        Future.delayed(
          const Duration(seconds: 1),
          () {
            setState(() {
              _animationPlaying = false;
            });
          },
        );
      },
      builder: (_, __, rejectedData) {
        return rejectedData.isNotEmpty
            ? _RejectedItemBin(widget: widget)
            : _CorrectItemBin(
                widget: widget,
                animationPlaying: _animationPlaying,
              );
      },
    );
  }
}

class _CorrectItemBin extends StatelessWidget {
  const _CorrectItemBin({
    required this.widget,
    required this.animationPlaying,
  });

  final BinWidget widget;
  final bool animationPlaying;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _BinImage(
          dumpsterType: widget.dumpsterType,
        ),
        if (animationPlaying)
          Positioned(
            top: -50,
            child: Lottie.asset(
              AssetPaths.itemSorted,
              height: 80,
              width: 80,
            ),
          ),
      ],
    );
  }
}

class _RejectedItemBin extends StatelessWidget {
  const _RejectedItemBin({
    required this.widget,
  });

  final BinWidget widget;

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();
    audioController.playSfx(SfxType.wrongBin);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          top: -60,
          child: Lottie.asset(
            AssetPaths.wrongBin,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            alignment: Alignment.bottomLeft,
          ),
        ),
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.red.withOpacity(0.8),
            BlendMode.modulate,
          ),
          child: _BinImage(
            dumpsterType: widget.dumpsterType,
          ),
        ),
      ],
    );
  }
}

class _BinImage extends StatelessWidget {
  const _BinImage({
    required this.dumpsterType,
  });

  final BinType dumpsterType;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      dumpsterType.assetPath,
      width: 100,
      height: 150,
    );
  }
}
