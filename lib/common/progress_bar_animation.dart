import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class ProgressBarAnimation extends StatelessWidget {
  const ProgressBarAnimation({
    super.key,
    required this.progressAnimation,
  });

  final Animation<double> progressAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 300,
      child: LiquidLinearProgressIndicator(
        borderRadius: 24,
        borderColor: Palette.neutralWhite,
        backgroundColor: Palette.neutralWhite,
        borderWidth: 4,
        valueColor: const AlwaysStoppedAnimation<Color>(Palette.secondary),
        value: progressAnimation.value,
        center: Text(
          'Loading...',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Palette.neutralWhite,
              ),
        ),
      ),
    );
  }
}
