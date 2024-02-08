import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    required this.content,
    required this.bottom,
    required this.ribbon,
    required this.themeColor,
    this.ecoImage,
  });

  final Widget content;
  final Widget bottom;
  final Widget ribbon;
  final Color themeColor;
  final String? ecoImage;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.only(top: 20),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 460,
              maxHeight: MediaQuery.sizeOf(context).height * 0.85,
              minHeight: 200,
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: content,
                    ),
                  ),
                ),
                gap8,
                bottom,
              ],
            ),
          ),
          Positioned(
            top: -30,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ribbon,
            ),
          ),
          if (ecoImage != null)
            Positioned(
              left: -105,
              bottom: -4,
              child: SvgPicture.asset(ecoImage!),
            ),
        ],
      ),
    );
  }
}
