import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    required this.content,
    required this.bottom,
    required this.themeColor,
    required this.ribbon,
  });

  final Widget content;
  final Widget bottom;
  final Color themeColor;
  final Widget ribbon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 500,
            maxHeight: MediaQuery.sizeOf(context).height * 0.8,
          ),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Palette.neutralWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.symmetric(
              horizontal: BorderSide(
                color: themeColor,
                width: 5,
              ),
              vertical: BorderSide(
                color: themeColor,
                width: 3,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: content,
                ),
              ),
              bottom,
            ],
          ),
        ),
        Positioned(
          top: -10,
          child: ribbon,
        ),
      ],
    );
  }
}
