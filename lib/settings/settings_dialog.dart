import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/common_dialog.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/settings/settings.dart';
import 'package:endless_runner/style/const_values.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  Future<String> _loadPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return CommonDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gap24,
          ValueListenableBuilder<bool>(
            valueListenable: settings.musicOn,
            builder: (context, musicOn, child) => _SettingsTile(
              text: 'Music',
              iconName: AssetPaths.iconMusic,
              value: musicOn,
              onSwitchTap: () => settings.toggleMusicOn(),
            ),
          ),
          gap12,
          ValueListenableBuilder<bool>(
            valueListenable: settings.soundsOn,
            builder: (context, soundsOn, child) => _SettingsTile(
              text: 'Sounds',
              iconName: AssetPaths.iconSound,
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
          FutureBuilder(
            future: _loadPackageInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  'Version: ${snapshot.data}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Palette.neutralBlack,
                      ),
                );
              }
              return gap16;
            },
          ),
        ],
      ),
      themeColor: Palette.secondaryDark,
      ribbon: RibbonHeader(
        text: 'Settings',
        withCloseIcon: true,
        onCloseTap: context.pop,
      ),
      ecoImage: AssetPaths.ecoSettings,
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
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
            trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
