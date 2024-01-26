import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

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
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14),
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
              onTap: onCloseTap ??
                  () => context
                    ..pop()
                    ..pop(),
              child: const SizedBox(
                height: 50,
                width: 50,
                //TODO change to asset
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
