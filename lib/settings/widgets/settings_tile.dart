import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.text,
    required this.iconName,
    required this.value,
    required this.onSwitchTap,
  });

  final String text;
  final String iconName;
  final bool value;
  final VoidCallback onSwitchTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: borderRadius16,
        color: Palette.secondaryLight,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconName,
            height: 24,
            width: 24,
          ),
          gap8,
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Palette.neutralBlack),
          ),
          const Spacer(),
          Switch(
            value: value,
            onChanged: (_) => onSwitchTap(),
            activeColor: Palette.neutralWhite,
            activeTrackColor: Palette.secondary,
            inactiveTrackColor: Palette.neutralLightGray,
            inactiveThumbColor: Palette.neutralDarkGray,
            trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
