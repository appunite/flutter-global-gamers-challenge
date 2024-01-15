import 'package:endless_runner/recycling_challenge/garbage_type_enum.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GarbageWidget extends StatelessWidget {
  const GarbageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.sizeOf(context).width;

    return Stack(
      fit: StackFit.expand,
      children: [
        const Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GarbageItemWidget(
                  garbageType: GarbageType.can,
                  rotationAngle: math.pi / 4,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.banana,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.plasticBottle,
                  rotationAngle: -math.pi / 6,
                  size: 80,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GarbageItemWidget(
                  garbageType: GarbageType.diaper,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.documents,
                  rotationAngle: -math.pi / 10,
                  size: 70,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.fishbones,
                  rotationAngle: -math.pi / 6,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.lightbulb,
                  rotationAngle: math.pi / 6,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GarbageItemWidget(
                  garbageType: GarbageType.cardboard,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.apple,
                  rotationAngle: math.pi / 10,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.glassBottle,
                  size: 80,
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
        Positioned(
          bottom: -70,
          left: widthSize / 6,
          child: Image.asset(
            'assets/images/recycling/dumpster_recycling.png',
            width: 150,
          ),
        ),
        Positioned(
          bottom: -70,
          left: widthSize / 2,
          child: Image.asset(
            'assets/images/recycling/dumpster.png',
            color: Colors.grey,
            width: 150,
          ),
        ),
      ],
    );
  }
}

class GarbageItemWidget extends StatelessWidget {
  const GarbageItemWidget({
    super.key,
    required this.garbageType,
    this.size = 60,
    this.rotationAngle = 0,
  });

  final GarbageType garbageType;
  final double size;
  final double rotationAngle;

  @override
  Widget build(BuildContext context) {
    return Draggable<GarbageType>(
      data: garbageType,
      childWhenDragging: SizedBox.square(dimension: size),
      feedback: GarbageItemContent(
        rotationAngle: rotationAngle,
        garbageType: garbageType,
        size: size,
      ),
      child: GarbageItemContent(
        rotationAngle: rotationAngle,
        garbageType: garbageType,
        size: size,
      ),
    );
  }
}

class GarbageItemContent extends StatelessWidget {
  const GarbageItemContent({
    super.key,
    required this.rotationAngle,
    required this.garbageType,
    required this.size,
  });

  final double rotationAngle;
  final GarbageType garbageType;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle,
      child: Image.asset(
        garbageType.assetPath,
        height: size,
        width: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
