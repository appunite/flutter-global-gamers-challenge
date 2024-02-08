import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameBackButton extends StatelessWidget {
  const GameBackButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GameIconButton(
      onTap: onTap ?? context.pop,
      iconName: AssetPaths.iconsBack,
    );
  }
}
