import 'package:better_world/challenges/recycling_challenge/garbage_controller.dart';
import 'package:better_world/challenges/recycling_challenge/garbage_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GarbageItemWidget extends StatelessWidget {
  const GarbageItemWidget({
    super.key,
    required this.garbageType,
  });

  final GarbageType garbageType;

  @override
  Widget build(BuildContext context) {
    final garbageMap = context.watch<GarbageController>();

    return Visibility(
      visible: !garbageMap.garbageSortedMap.entries.firstWhere((entry) => entry.key == garbageType).value,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Draggable<GarbageType>(
        data: garbageType,
        childWhenDragging: SizedBox.square(dimension: garbageType.size),
        feedback: GarbageItemContent(
          garbageType: garbageType,
        ),
        child: GarbageItemContent(
          garbageType: garbageType,
        ),
      ),
    );
  }
}

class GarbageItemContent extends StatelessWidget {
  const GarbageItemContent({
    super.key,
    required this.garbageType,
  });

  final GarbageType garbageType;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: garbageType.rotationAngle,
      child: Semantics(
        label: garbageType.semanticLabel,
        child: SizedBox(
          height: garbageType.size,
          width: garbageType.size,
          child: SvgPicture.asset(
            garbageType.assetPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
