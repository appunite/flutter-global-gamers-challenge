import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/common_dialog.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/settings/settings.dart';
import 'package:endless_runner/style/const_values.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return CommonDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gap20,
          ValueListenableBuilder<bool>(
            valueListenable: settings.musicOn,
            builder: (context, musicOn, child) => SettingsTile(
              text: 'Music',
              iconName: AssetPaths.appleCore,
              value: musicOn,
              onSwitchTap: () => settings.toggleMusicOn(),
            ),
          ),
          gap12,
          ValueListenableBuilder<bool>(
            valueListenable: settings.soundsOn,
            builder: (context, soundsOn, child) => SettingsTile(
              text: 'Sounds',
              iconName: AssetPaths.bananaPeel,
              value: soundsOn,
              onSwitchTap: () => settings.toggleSoundsOn(),
            ),
          ),
          gap12,
        ],
      ),
      bottom: Column(
        children: [
          Text(
            'User: ID', // TODO
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Palette.neutralBlack,
                ),
          ),
          Text(
            'Version: 0.1.0', // TODO
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Palette.neutralBlack,
                ),
          ),
        ],
      ),
      themeColor: Palette.secondaryDark,
      ribbon: RibbonHeader(
        customChild: Row(
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Palette.secondaryDark,
                  ),
            ),
            GestureDetector(
              onTap: context.pop,
              child: const Icon(
                Icons.close,
                color: Palette.neutralWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          Image.asset(
            iconName,
            height: 24,
            width: 24,
          ),
          gap8,
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          Switch(
            value: value,
            onChanged: (_) => onSwitchTap(),
            activeColor: Palette.neutralWhite,
            activeTrackColor: Palette.secondary,
            inactiveTrackColor: Palette.neutralLightGray,
            inactiveThumbColor: Palette.neutralDarkGray,
            trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
