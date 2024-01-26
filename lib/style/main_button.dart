import 'package:endless_runner/style/palette.dart';
import 'package:endless_runner/style/pushable_button.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    this.width,
    required this.onPressed,
    this.backgroundColor = Palette.primary,
    this.activeColor = Palette.primaryDark,
  });

  factory MainButton.secondary({
    required String text,
    required VoidCallback onPressed,
    double? width,
  }) {
    return MainButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: Palette.secondary,
      activeColor: Palette.secondaryDark,
      width: width,
    );
  }

  final String text;
  final double? width;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  /// Color when button is pressed
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return PushableButton(
      width: width,
      activeColor: activeColor,
      hslColor: HSLColor.fromColor(backgroundColor),
      height: 48,
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
