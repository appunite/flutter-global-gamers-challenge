import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/icon_button.dart';
import 'package:better_world/main_map/main_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MapButton extends StatelessWidget {
  const MapButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GameIconButton(
      onTap: onTap ?? () => context.go(MainMapScreen.routePath),
      iconName: AssetPaths.iconsMap,
      width: 56,
      height: 56,
    );
  }
}
