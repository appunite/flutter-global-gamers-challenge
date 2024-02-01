import 'package:endless_runner/challenges/recycling_challenge/garbage_item_widget.dart';
import 'package:endless_runner/challenges/recycling_challenge/garbage_type_enum.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:flutter/material.dart';

class GarbageWidget extends StatelessWidget {
  const GarbageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 40,
            child: GarbageItemWidget(
              garbageType: GarbageType.canOrange,
            ),
          ),
          Positioned(
            top: 50,
            child: GarbageItemWidget(
              garbageType: GarbageType.apple,
            ),
          ),
          Positioned(
            top: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GarbageItemWidget(
                  garbageType: GarbageType.bag,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.metalCan,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.banana,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.canPink,
                ),
              ],
            ),
          ),
          Positioned(
            top: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GarbageItemWidget(
                  garbageType: GarbageType.glassBottle,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.plasticBag,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.can,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.glass,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.packaging,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.waterBottle,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.fishbones,
                ),
              ],
            ),
          ),
          Positioned(
            top: 110,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GarbageItemWidget(
                  garbageType: GarbageType.paper,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.bread,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.bigWater,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.plasticBox,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.glassJar,
                ),
                GarbageItemWidget(
                  garbageType: GarbageType.watermelon,
                ),
              ],
            ),
          ),
          gap24,
        ],
      ),
    );
  }
}
