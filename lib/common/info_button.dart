import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/icon_button.dart';
import 'package:better_world/style/const_values.dart';
import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: displayAdditionalPadding ? const EdgeInsets.only(right: 12) : EdgeInsets.zero,
      child: GameIconButton(
        onTap: onTap,
        padding: const EdgeInsets.all(8),
        iconName: AssetPaths.iconsInfo,
        width: 40,
        height: 40,
      ),
    );
  }
}
