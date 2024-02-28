import 'package:better_world/audio/audio_controller.dart';
import 'package:better_world/audio/sounds.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RibbonHeader extends StatelessWidget {
  const RibbonHeader({
    super.key,
    this.text,
    this.height,
    this.width,
    this.ribbonImage,
    this.customChild,
    this.withCloseIcon = false,
    this.onCloseTap,
  }) : assert(text != null || customChild != null, 'Either text or customChild cannot be null');

  final String? text;
  final double? height;
  final double? width;
  final String? ribbonImage;
  final bool withCloseIcon;
  final Widget? customChild;
  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SvgPicture.asset(
          ribbonImage ?? AssetPaths.ribbonBlue,
          width: width ?? 490,
          height: 60,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: customChild ??
              Text(
                text!,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Palette.neutralWhite,
                      overflow: TextOverflow.ellipsis,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
        ),
        if (withCloseIcon)
          Positioned(
            right: 50,
            top: 4,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                context.read<AudioController>().playSfx(SfxType.buttonTap);
                if (onCloseTap != null) {
                  onCloseTap!.call();
                } else {
                  context
                    ..pop()
                    ..pop();
                }
              },
              child: SizedBox(
                height: 45,
                width: 45,
                //TODO change to asset
                child: SvgPicture.asset(AssetPaths.iconsCloseWhite),
              ),
            ),
          ),
      ],
    );
  }
}
