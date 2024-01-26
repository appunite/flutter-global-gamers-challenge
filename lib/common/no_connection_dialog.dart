import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/common_dialog.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';

class NoConnectionDialog extends StatelessWidget {
  const NoConnectionDialog({
    super.key,
    required this.onTryAgain,
    required this.onPlayOffline,
  });

  final VoidCallback onTryAgain;
  final VoidCallback onPlayOffline;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'Looks like you\'re offline! You can still play, but your progress will be lost.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Palette.neutralBlack,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      bottom: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainButton.secondary(
            width: 150,
            onPressed: onTryAgain,
            text: 'Try Again',
          ),
          gap12,
          MainButton(
            width: 170,
            onPressed: onTryAgain,
            text: 'Play Offline',
          ),
        ],
      ),
      themeColor: Palette.error,
      ribbon: const RibbonHeader(
        ribbonImage: AssetPaths.ribbonRed,
        text: 'No Internet Connection',
      ),
      ecoImage: AssetPaths.ecoConnection,
    );
  }
}
