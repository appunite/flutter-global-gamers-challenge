import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/common_dialog.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/style/const_values.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/main_button.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChallengeIntroductionDialog extends StatelessWidget {
  const ChallengeIntroductionDialog({
    super.key,
    required this.challenge,
    required this.onButtonPressed,
  });

  final ChallengeType challenge;
  final VoidCallback onButtonPressed;

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
            text: challenge.instruction1,
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
        withCloseIcon: true,
        text: challenge.title,
      ),
      ecoImage: AssetPaths.ecoBag,
    );
  }
}

class InstructionContainer extends StatelessWidget {
  const InstructionContainer({
    super.key,
    required this.text,
    //TODO required later
    this.assetPath,
  });

  final String text;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius12,
        color: Palette.secondaryLight,
      ),
      child: Row(
        children: [
          if (assetPath != null)
            ClipRRect(
              borderRadius: borderRadius12,
              child: SvgPicture.asset(
                assetPath!,
                width: 65,
                height: 70,
              ),
            ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
