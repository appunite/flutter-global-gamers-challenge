import 'dart:io';

import 'package:better_world/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:better_world/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:better_world/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:better_world/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:better_world/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/challenges/lights_out_challenge/lights_out_challenge_screen.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';
import 'package:flutter/foundation.dart';

enum ChallengeType {
  pipelines(
    title: 'Pipeline Puzzle',
    description: 'Clean water is vital. Fixing pipelines prevents pollution and saves water.',
    instruction1: 'Connect pipes correctly to stop leaks and make the sewage system work properly.',
    instruction2: 'Finish as quickly as possible to collect the most points.',
    instructionAsset1: AssetPaths.infoPipes1,
    instructionAsset2: AssetPaths.infoTimer,
    completedText:
        'By fixing leaky pipelines, you\'ve helped conserve water\nand protect aquatic ecosystems in Better World.',
    routePath: PipesChallengeScreen.routePath,
    badgeDescription:
        "By fixing leaky pipelines, you've helped conserve water and protect aquatic ecosystems in Better World.",
    badgeTitle: 'Water Guardian',
    badgeAsset: AssetPaths.pipesBadge,
    badgeLogoUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fpipes_badge.jpg?alt=media&token=8248ca9b-a51d-454f-9345-e5efee34faa1',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fnew_badges%2Fwallet_badge_06.png?alt=media&token=3f1facc8-65cd-4c92-b05d-c2610125841e',
    organizationUrl: 'https://www.unep.org/explore-topics/water/what-we-do/global-wastewater-initiative-gwwi',
    uuid: '19e199a2-0582-4c24-bfd4-0e2eb764f8c0',
  ),
  recycling(
    title: 'Recycle Rush',
    description: 'Proper recycling reduces waste. Let\'s sort recyclables correctly!',
    instruction1: 'Drag items to the right bins. Accurate sorting counts!',
    instruction2: 'Finish as quickly as possible to collect the most points.',
    instructionAsset1: AssetPaths.infoRecycle1,
    instructionAsset2: AssetPaths.infoRecycle2,
    completedText: 'Your recycling skills are key\n to reducing waste and conserving resources.',
    routePath: RecyclingChallengeScreen.routePath,
    badgeDescription: "Your recycling skills are key to reducing waste and conserving resources.",
    badgeTitle: 'Recycling Master',
    badgeAsset: AssetPaths.recyclingBadge,
    badgeLogoUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2FBadges-5.jpg?alt=media&token=4737dea8-97b4-49e5-8f22-747554cb942b',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fnew_badges%2Fwallet_badge_05.png?alt=media&token=b780f8dc-2cdb-4771-adbb-f1668857532e',
    organizationUrl: 'https://www.bir.org',
    uuid: '4d9ee8c5-f9b7-4378-8d7d-1ab63a2ac03d',
  ),
  solarPanel(
    title: 'Solar Panel Cleanup',
    description: 'Solar panels convert sunlight into electricity. When dirty, efficiency drops.',
    instruction1: 'Scratch the screen to clean and increase solar energy output.',
    instruction2: 'Aim for 100% clean in 10 seconds for max points!',
    completedText: 'You\'ve cleaned the solar panels,\nincreasing the city\'s energy efficiency!',
    instructionAsset1: AssetPaths.infoSolarPanel1,
    instructionAsset2: AssetPaths.infoSolarPanel2,
    routePath: SolarPanelChallengeScreen.routePath,
    badgeDescription: "You've cleaned the solar panels, increasing the city's energy efficiency!",
    badgeTitle: 'Energy Champion',
    badgeAsset: AssetPaths.panelBadge,
    badgeLogoUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2FBadges-7.jpg?alt=media&token=89479e31-b4bc-47c4-989d-6e17afc50cc8',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fnew_badges%2Fwallet_badge_01.png?alt=media&token=cbfd6b8d-b062-4db5-accd-ee0a55b37eb7',
    organizationUrl: 'https://www.eurosolar.org/donate/',
    uuid: '3b2f82cf-6c54-4e68-a80e-999d6d226fe7',
  ),
  trees(
    title: 'Plant a Forest',
    description: 'Trees combat climate change and increase biodiversity.',
    instruction1: 'Tap the screen as fast as possible to plant new trees.',
    instruction2: 'Get 1 point for each planted tree and combat deforestation. ',
    instructionAsset1: AssetPaths.infoTree1,
    instructionAsset2: AssetPaths.infoTree2,
    completedText: 'Thanks to your tree planting,\nBetter World breathes easier with increased green cover.',
    routePath: TreesChallengeScreen.routePath,
    badgeDescription: 'Thanks to your tree planting, Better World breathes easier with increased green cover.',
    badgeTitle: 'Forest Friend',
    badgeAsset: AssetPaths.treeBadge,
    badgeLogoUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2FBadge_forest.jpg?alt=media&token=45d0e303-715d-43ff-805d-b098d030a7d8',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fnew_badges%2Fwallet_badge_03.png?alt=media&token=19d22b86-306d-402e-9ade-b496a5e39a10',
    organizationUrl: 'https://onetreeplanted.org/products/plant-trees',
    uuid: 'ac3e10a6-7355-4dd1-927d-912998f27e7d',
  ),
  ocean(
    title: 'Plastic Free',
    description: 'Oceans are polluted with plastics. Cleaning them helps marine life thrive.',
    instruction1: 'Use platformKey to move the ship and aim to shoot micro-plastics.',
    instruction2: 'Earn 1 point for each plastic shot in 30 seconds. Avoid hits - each one will cost you 1 point!',
    instructionAsset1: AssetPaths.infoPlastics1,
    instructionAsset2: AssetPaths.infoPlastics2,
    completedText: 'Your dedication to removing plastics\nkeeps our oceans clean and marine life safe.',
    routePath: OceanChallengeScreen.routePath,
    badgeAsset: AssetPaths.oceanBadge,
    badgeTitle: 'Ocean Protector',
    badgeDescription: 'Your dedication to removing plastics keeps our oceans clean and marine life safe',
    badgeLogoUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2FBadge-4.jpg?alt=media&token=649e0615-bfad-48aa-a09a-3766a95e710c',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fnew_badges%2Fwallet_badge_04.png?alt=media&token=1272992a-d984-42c5-9fa3-4d4bdfef709a',
    organizationUrl: 'https://theoceancleanup.com/help-clean/',
    uuid: 'd57a4ff4-2a51-4ae8-a93e-83c9fcdfe3e1',
  ),
  lightsOut(
    title: 'Lights Out Challenge',
    description: 'Turning off lights saves power and protects wildlife.',
    instruction1: 'platformKey to make an Eco jump and turn off the lights, saving energy! You can use double jump!',
    instruction2: 'Turn off as many lights as you can in 30 seconds and earn points.',
    completedText: 'Your action in reducing light pollution\n helps save energy and protect nocturnal wildlife.',
    routePath: LightsOutChallengeScreen.routePath,
    instructionAsset1: AssetPaths.infoLightsOut1,
    instructionAsset2: AssetPaths.infoTimer,
    badgeAsset: AssetPaths.lightsOffBadge,
    badgeTitle: 'Carbon Footprint',
    badgeDescription: 'Your action in reducing light pollution helps save energy and protect nocturnal wildlife.',
    badgeLogoUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2FBadges-6.jpg?alt=media&token=1ed88812-983b-4b58-86ba-a09645a78a7e',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fnew_badges%2Fwallet_badge_02.png?alt=media&token=c9e3fa1d-2b10-4761-992d-4df84e37edcc',
    organizationUrl: 'https://www.savingourstars.org/howtohelp',
    uuid: 'f64c3820-4e6b-40f8-a0e3-93d5a7612f9d',
  );

  const ChallengeType({
    required this.title,
    required this.description,
    required this.instruction1,
    required this.instruction2,
    required this.instructionAsset1,
    required this.instructionAsset2,
    required this.completedText,
    required this.routePath,
    required this.badgeAsset,
    required this.badgeDescription,
    required this.badgeTitle,
    required this.badgeUrl,
    required this.badgeLogoUrl,
    required this.organizationUrl,
    required this.uuid,
  });

  final String title;
  final String description;
  final String instruction1;
  final String instruction2;
  final String instructionAsset1;
  final String instructionAsset2;
  final String completedText;
  final String routePath;
  final String badgeAsset;
  final String badgeDescription;
  final String badgeTitle;
  final String badgeUrl;
  final String badgeLogoUrl;
  final String organizationUrl;
  final String uuid;

  int? getChallengeScore(ChallengesEntity challenges) {
    return switch (this) {
      ChallengeType.lightsOut => challenges.city,
      ChallengeType.ocean => challenges.ocean,
      ChallengeType.pipelines => challenges.pipes,
      ChallengeType.recycling => challenges.recycling,
      ChallengeType.solarPanel => challenges.solarPanel,
      ChallengeType.trees => challenges.trees,
    };
  }
}

extension StringExtension on String {
  String oceanPlatformWording() {
    String? str;
    if (kIsWeb || Platform.isMacOS) {
      str = 'your mouse or keyboard arrows';
    } else {
      str = 'your finger';
    }

    return replaceFirst('platformKey', str);
  }

  String lightsOutPlatformWording() {
    String? str;
    if (kIsWeb || Platform.isMacOS) {
      str = 'Click on the screen or use spacebar';
    } else {
      str = 'Tap on the screen';
    }

    return replaceFirst('platformKey', str);
  }
}
