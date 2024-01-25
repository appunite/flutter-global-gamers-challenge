import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Palette.overlay,
      ),
    );
  }
}
