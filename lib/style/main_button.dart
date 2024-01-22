import 'package:endless_runner/style/palette.dart';
import 'package:endless_runner/style/pushable_button.dart';
import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  const MainButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = Palette.primary,
    this.activeColor = Palette.primaryDark,
  });

  factory MainButton.secondary({
    required String text,
    required VoidCallback onPressed,
  }) {
    return MainButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: Palette.secondary,
      activeColor: Palette.secondaryDark,
    );
  }

  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  /// Color when button is pressed
  final Color activeColor;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return PushableButton(
      activeColor: widget.activeColor,
      hslColor: HSLColor.fromColor(widget.backgroundColor),
      height: 48,
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
