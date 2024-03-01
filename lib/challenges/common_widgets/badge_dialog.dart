import 'dart:io';

import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:better_world/challenges/challenge_type_enum.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/common/common_dialog.dart';
import 'package:better_world/common/ribbon_header.dart';
import 'package:better_world/player_progress/player_progress_controller.dart';
import 'package:better_world/style/gaps.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class BadgeDialog extends StatelessWidget {
  const BadgeDialog({
    super.key,
    required this.challengeType,
    required this.playerProgress,
  });

  final ChallengeType challengeType;
  final PlayerProgressController playerProgress;

  @override
  Widget build(BuildContext context) {
/*    final String badgeJSON = _badgePass
      ..replaceFirst('NICK_REPLACEMENT', playerProgress.playerNick)
      ..replaceFirst('BADGE_IMAGE_REPLACEMENT', challengeType.badgeLogoUrl)
      ..replaceFirst('BADGE_HERO_REPLACEMENT', challengeType.badgeUrl)
      ..replaceFirst('POINTS_REPLACEMENT', '123');*/

    final String badgeJSON = replacePlaceholders(
      _badgePass,
      '123',
      challengeType.badgeUrl,
      playerProgress.playerNick,
      challengeType.badgeLogoUrl,
      challengeType.badgeTitle,
    );

    //debugPrint(badgeJSON);

    return CommonDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gap4,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              challengeType.badgeTitle,
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
              challengeType.badgeDescription,
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
              challengeType.badgeAsset,
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
    String points,
    String badgeHero,
    String nickReplacement,
    String badgeImageReplacement,
    String badgeTitle,
  ) {
    badgeJSON = badgeJSON.replaceAll("POINTS_REPLACEMENT", points);
    badgeJSON = badgeJSON.replaceAll("BADGE_HERO_REPLACEMENT", badgeHero);
    badgeJSON = badgeJSON.replaceAll("NICK_REPLACEMENT", nickReplacement);
    badgeJSON = badgeJSON.replaceAll("BADGE_IMAGE_REPLACEMENT", badgeImageReplacement);
    badgeJSON = badgeJSON.replaceAll("TITLE_REPLACEMENT", badgeTitle);

    return badgeJSON;
  }

  void _onError(BuildContext context, Object error) {
    debugPrint("ERROR: $error");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error.toString()),
      ),
    );
  }

  void _onSuccess(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Pass has been successfully added to the Google Wallet.'),
        ),
      );

  void _onCanceled(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.yellow,
          content: Text('Adding a pass has been canceled.'),
        ),
      );
}

final String _passId = const Uuid().v4();
const String _passClass = 'test';
const String _issuerId = '3388000000022304025';
const String _issuerEmail = 'jk.jakubkostrzewski@gmail.com';

final String _badgePass = """
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#4285f4",
            "logo": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Google I/O '22 [DEMO ONLY]"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Eco Hero"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "NICK_REPLACEMENT"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg"
              }
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "POINTS_REPLACEMENT",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
""";
