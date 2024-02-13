import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/common_dialog.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/settings/settings.dart';
import 'package:better_world/settings/widgets/reset_settings_row.dart';
import 'package:better_world/settings/widgets/settings_footer.dart';
import 'package:better_world/settings/widgets/settings_tile.dart';
import 'package:better_world/settings/widgets/username_settings_row.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return CommonDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gap24,
          const UserNameSettingsRow(),
          gap12,
          ValueListenableBuilder<bool>(
            valueListenable: settings.musicOn,
            builder: (context, musicOn, child) => SettingsTile(
              text: 'Music',
              iconName: AssetPaths.iconMusic,
              value: musicOn,
              onSwitchTap: () => settings.toggleMusicOn(),
            ),
          ),
          gap12,
          ValueListenableBuilder<bool>(
            valueListenable: settings.soundsOn,
            builder: (context, soundsOn, child) => SettingsTile(
              text: 'Sounds',
              iconName: AssetPaths.iconSound,
              value: soundsOn,
              onSwitchTap: () => settings.toggleSoundsOn(),
            ),
          ),
          gap12,
          const ResetSettingsRow(),
          gap12,
        ],
      ),
      bottom: const SettingsFooter(),
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
