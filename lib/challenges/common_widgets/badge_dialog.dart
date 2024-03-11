import 'dart:io';

import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/challenges/common_widgets/google_wallet_badge_json.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/common_dialog.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/common/success_snack_bar.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BadgeDialog extends StatelessWidget {
  const BadgeDialog({
    super.key,
    required this.badgeTitle,
    required this.badgeDescription,
    required this.badgeAsset,
    required this.isGameFinished,
    this.score,
    this.challengeType,
  });

  factory BadgeDialog.challengeCompleted({
    required ChallengeType challengeType,
    required PlayerProgressController playerProgress,
    int? score,
  }) {
    return BadgeDialog(
      badgeTitle: challengeType.badgeTitle,
      badgeDescription: challengeType.badgeDescription,
      badgeAsset: challengeType.badgeAsset,
      score: score ?? challengeType.getChallengeScore(playerProgress.challenges),
      challengeType: challengeType,
      isGameFinished: false,
    );
  }

  factory BadgeDialog.gameCompleted({
    required PlayerProgressController playerProgress,
  }) {
    return const BadgeDialog(
      badgeTitle: gameCompletedBadgeTitle,
      badgeDescription: gameCompletedBadgeDescription,
      badgeAsset: gameCompletedBadgeAsset,
      isGameFinished: true,
    );
  }

  final String badgeTitle;
  final String badgeDescription;
  final String badgeAsset;
  final ChallengeType? challengeType;
  final int? score;
  final bool isGameFinished;

  @override
  Widget build(BuildContext context) {
    final playerProgress = context.watch<PlayerProgressController>();

    final String badgeJSON = isGameFinished
        ? replacePlaceholders(
            googleWalletBadgePass,
            playerProgress.challenges.getAllChallengesScores(),
            gameCompletedBadgeUrl,
            playerProgress.playerNick,
            gameCompletedLogoUrl,
            badgeTitle,
          )
        : replacePlaceholders(
            googleWalletBadgePass,
            score!,
            challengeType!.badgeUrl,
            playerProgress.playerNick,
            challengeType!.badgeLogoUrl,
            badgeTitle,
          );

    debugPrint(badgeJSON);

    return CommonDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gap4,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              badgeTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Palette.secondaryDark,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          gap4,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              badgeDescription,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Palette.neutralBlack,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          gap12,
          Container(
            height: 98,
            width: 98,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(90)),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  spreadRadius: 1,
                  color: Palette.neutralBlack.withOpacity(0.2),
                ),
              ],
            ),
            child: SvgPicture.asset(
              badgeAsset,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
      bottom: kIsWeb || !Platform.isAndroid
          ? const SizedBox.shrink()
          : AddToGoogleWalletButton(
              pass: badgeJSON,
              onError: (Object error) => _onError(context, error),
              onSuccess: () => _onSuccess(context),
              onCanceled: () => _onCanceled(context),
            ),
      themeColor: Palette.secondaryDark,
      ribbon: RibbonHeader(
        ribbonImage: AssetPaths.ribbonBlue,
        text: 'Badge Unlocked',
        withCloseIcon: true,
        onCloseTap: () => context.pop(),
      ),
    );
  }

  String replacePlaceholders(
    String badgeJSON,
    int points,
    String badgeHero,
    String nickReplacement,
    String badgeImageReplacement,
    String badgeTitle,
  ) {
    badgeJSON = badgeJSON.replaceAll("POINTS_REPLACEMENT", points.toString());
    badgeJSON = badgeJSON.replaceAll("BADGE_HERO_REPLACEMENT", badgeHero);
    badgeJSON = badgeJSON.replaceAll("NICK_REPLACEMENT", nickReplacement);
    badgeJSON = badgeJSON.replaceAll("BADGE_IMAGE_REPLACEMENT", badgeImageReplacement);
    badgeJSON = badgeJSON.replaceAll("TITLE_REPLACEMENT", badgeTitle);
    badgeJSON = badgeJSON.replaceAll("UUID_REPLACEMENT", const Uuid().v4().toString());

    return badgeJSON;
  }

  void _onError(BuildContext context, Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Palette.error,
        content: Text(error.toString()),
      ),
    );
  }

  void _onSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBarBuilder(
        icon: SvgPicture.asset(
          AssetPaths.iconsCheckmark,
          height: 32,
          width: 32,
        ),
        title: 'Your badge is saved!',
      ),
    );
    context.pop();
  }

  void _onCanceled(BuildContext context) => context.pop();
}
