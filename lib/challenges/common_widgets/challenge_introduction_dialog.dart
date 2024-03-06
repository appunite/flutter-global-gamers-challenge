import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/common_widgets/introduction_container.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/common_dialog.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/main_button.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';

class ChallengeIntroductionDialog extends StatelessWidget {
  const ChallengeIntroductionDialog({
    super.key,
    required this.challenge,
    required this.onButtonPressed,
    this.onCloseTap,
  });

  final ChallengeType challenge;
  final VoidCallback onButtonPressed;
  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gap24,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              challenge.description,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Palette.secondaryDark,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          gap12,
          InstructionContainer(
            text: challenge == ChallengeType.ocean
                ? challenge.instruction1.oceanPlatformWording()
                : challenge == ChallengeType.lightsOut
                    ? challenge.instruction1.lightsOutPlatformWording()
                    : challenge.instruction1,
            assetPath: challenge.instructionAsset1,
          ),
          gap12,
          InstructionContainer(
            text: challenge.instruction2,
            assetPath: challenge.instructionAsset2,
          ),
          gap12,
        ],
      ),
      bottom: MainButton(
        onPressed: (_) => onButtonPressed(),
        text: 'I\'m ready!',
        width: 180,
      ),
      themeColor: Palette.secondaryDark,
      ribbon: RibbonHeader(
        onCloseTap: onCloseTap,
        withCloseIcon: true,
        text: challenge.title,
      ),
      ecoImage: AssetPaths.ecoBag,
    );
  }
}
