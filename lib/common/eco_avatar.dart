import 'package:better_world/common/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EcoAvatar extends StatelessWidget {
  const EcoAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: 100,
      child: RiveAnimation.asset(
        AssetPaths.ecoAnimation,
        animations: ['Blinking'],
        artboard: 'Eco',
        stateMachines: ['StateMachine'],
      ),
    );
  }
}
