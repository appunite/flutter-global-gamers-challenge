import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:endless_runner/challenges/challenge_type_enum.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/common/common_dialog.dart';
import 'package:endless_runner/common/ribbon_header.dart';
import 'package:endless_runner/style/gaps.dart';
import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class BadgeDialog extends StatelessWidget {
  const BadgeDialog({
    super.key,
    required this.challengeType,
  });

  final ChallengeType challengeType;

  @override
  Widget build(BuildContext context) {
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(90)),
            ),
            child: SvgPicture.asset(
              challengeType.badgeAsset,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
      bottom: AddToGoogleWalletButton(
        pass: _examplePass,
        onError: (Object error) => _onError(context, error),
        onSuccess: () => _onSuccess(context),
        onCanceled: () => _onCanceled(context),
      ),
      themeColor: Palette.accentDark,
      ribbon: RibbonHeader(
        ribbonImage: AssetPaths.ribbonBlue,
        text: 'Badge Unlocked',
        withCloseIcon: true,
        onCloseTap: () => context.pop(),
      ),
    );
  }

  void _onError(BuildContext context, Object error) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(error.toString()),
        ),
      );

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

final String _examplePass = """ 
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
                "value": "Attendee"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Alex McJacobs"
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
                "body": "1234",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
""";
