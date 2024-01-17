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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GarbageItemWidget(
                garbageType: GarbageType.can,
              ),
              GarbageItemWidget(
                garbageType: GarbageType.banana,
              ),
              GarbageItemWidget(
                garbageType: GarbageType.plasticBottle,
              ),
            ],
          ),
          gap20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GarbageItemWidget(
                garbageType: GarbageType.diaper,
              ),
              GarbageItemWidget(
                garbageType: GarbageType.documents,
              ),
              GarbageItemWidget(
                garbageType: GarbageType.fishbones,
              ),
              GarbageItemWidget(
                garbageType: GarbageType.lightbulb,
              ),
            ],
          ),
          gap20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GarbageItemWidget(
                garbageType: GarbageType.cardboard,
              ),
              GarbageItemWidget(
                garbageType: GarbageType.apple,
              ),
              GarbageItemWidget(
                garbageType: GarbageType.glassBottle,
              ),
            ],
          ),
          gap20,
        ],
      ),
    );
  }
}
