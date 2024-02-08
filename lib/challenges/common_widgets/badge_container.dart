import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BadgeContainer extends StatelessWidget {
  const BadgeContainer({
    super.key,
    required this.badgeName,
    required this.badgeImage,
  });

  final String badgeName;
  final String badgeImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      width: 320,
      height: 150,
      decoration: BoxDecoration(
        color: Palette.neutralWhite.withOpacity(.3),
        borderRadius: borderRadius24,
      ),
      child: Column(
        children: [
          Text(
            badgeName.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          gap8,
          SvgPicture.asset(
            badgeImage,
            height: 80,
            width: 80,
          ),
        ],
      ),
    );
  }
}
