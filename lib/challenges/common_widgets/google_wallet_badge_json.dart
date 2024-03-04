import 'package:uuid/uuid.dart';

final String _passId = const Uuid().v4();
const String _passClass = 'test';
const String _issuerId = '3388000000022304025';
const String _issuerEmail = 'jk.jakubkostrzewski@gmail.com';

final String googleWalletBadgePass = """
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
        "hexBackgroundColor": "#3caefb",
        "logo": {
          "sourceUri": {
            "uri": "BADGE_IMAGE_REPLACEMENT"
          }
        },
        "cardTitle": {
          "defaultValue": {
            "language": "en",
            "value": "TITLE_REPLACEMENT"
          }
        },
        "subheader": {
          "defaultValue": {
            "language": "en",
            "value": "NICK_REPLACEMENT"
          }
        },
        "header": {
          "defaultValue": {
            "language": "en",
            "value": "POINTS_REPLACEMENT points"
          }
        },
        "heroImage": {
          "sourceUri": {
            "uri": "BADGE_HERO_REPLACEMENT"
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
