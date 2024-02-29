import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Palette.overlay,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
