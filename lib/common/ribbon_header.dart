import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class RibbonHeader extends StatelessWidget {
  const RibbonHeader({
    super.key,
    this.text,
    this.height,
    this.width,
    this.ribbonImage,
    this.customChild,
  }) : assert(text != null || customChild != null, 'Either text or customChild cannot be null');

  final String? text;
  final double? height;
  final double? width;
  final String? ribbonImage;
  final Widget? customChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ribbonImage ?? AssetPaths.documents), //TODO
          fit: BoxFit.contain,
        ),
      ),
      child: Center(
        child: customChild ??
            Text(
              text!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Palette.neutralWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}
