import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/icon_button.dart';
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
      //TODO(kostrzewsky): Move player to the map
      onTap: onTap ?? () => context.go('/'),
      iconName: AssetPaths.iconsMap,
      width: 56,
      height: 56,
    );
  }
}
