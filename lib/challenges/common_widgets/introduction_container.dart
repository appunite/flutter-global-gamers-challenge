import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstructionContainer extends StatelessWidget {
  const InstructionContainer({
    super.key,
    required this.text,
    required this.assetPath,
    this.color = Palette.secondaryLight,
  });

  final String text;
  final String? assetPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: borderRadius12,
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (assetPath != null)
            ClipRRect(
              borderRadius: borderRadius12,
              child: SvgPicture.asset(
                assetPath!,
                width: 75,
                height: 88,
              ),
            ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
