import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GameIconButton extends StatelessWidget {
  const GameIconButton({
    super.key,
    required this.iconName,
    this.onTap,
    this.padding,
    this.width,
    this.height,
  });

  final String iconName;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        context.read<AudioController>().playSfx(SfxType.buttonTap);
        onTap?.call();
      },
      child: Container(
        width: width ?? 44,
        height: height ?? 44,
        decoration: BoxDecoration(
          color: Palette.neutralWhite,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              spreadRadius: 1,
              color: Palette.neutralBlack.withOpacity(0.2),
            ),
          ],
        ),
        padding: padding ?? const EdgeInsets.all(12),
        child: Center(
          child: SvgPicture.asset(
            iconName,
            height: 32,
            width: 32,
          ),
        ),
      ),
    );
  }
}
