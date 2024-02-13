import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProgress = context.watch<PlayerProgressController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Player: ',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Palette.neutralBlack,
                  ),
            ),
            SelectableText(
              playerProgress.playerId,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Palette.neutralBlack,
                  ),
            ),
          ],
        ),
        FutureBuilder(
          future: _loadPackageInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                'Version: ${snapshot.data}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Palette.neutralBlack,
                    ),
              );
            }
            return gap16;
          },
        ),
      ],
    );
  }

  Future<String> _loadPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
