import 'package:better_world/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:better_world/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:better_world/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:better_world/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:better_world/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:better_world/common/asset_paths.dart';
import 'package:better_world/challenges/lights_out_challenge/lights_out_challenge_screen.dart';
import 'package:better_world/player_progress/entities/challenges_entity.dart';

enum ChallengeType {
  pipelines(
    title: 'Pipeline Puzzle',
    description: 'Clean water is vital. Fixing pipelines prevents pollution and saves water.',
    instruction1: 'Connect pipes correctly to stop leaks and make the sewage machine work properly.',
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
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fpipes_badge.svg?alt=media&token=3129490c-2ba9-4e5e-8c97-3f407bbde5c1',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fpipes_badge_hero.svg?alt=media&token=ec085b24-8573-4363-aa3e-faef9bb6ea41',
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
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Frecycling_badge.svg?alt=media&token=d3bd2cf9-3e33-4f13-84b9-2d8501caeb7d',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Frecycling_badge_hero.svg?alt=media&token=cde27413-c3b3-4968-91a9-4865bf0d7ce6',
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
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fpanel_badge.svg?alt=media&token=67d72897-2950-4ab8-8b16-465810fbefdf',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fpanel_badge_hero.svg?alt=media&token=8ac058c7-c9ac-4cf9-8cde-985b3a6f6362',
  ),
  trees(
    title: 'Plant a Forest',
    description: 'Trees combat climate change and increase biodiversity.',
    instruction1: 'Tap the button as fast as possible to plant a new tree.',
    instruction2: 'Get 1 point for each planted tree and combat deforestation. ',
    instructionAsset1: AssetPaths.infoTree1,
    instructionAsset2: AssetPaths.infoTree2,
    completedText: 'Thanks to your tree planting,\nBetter World breathes easier with increased green cover.',
    routePath: TreesChallengeScreen.routePath,
    badgeDescription: 'Thanks to your tree planting, Better World breathes easier with increased green cover.',
    badgeTitle: 'Forest Friend',
    badgeAsset: AssetPaths.treeBadge,
    badgeLogoUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Ftrees_badge.svg?alt=media&token=d37f5658-7bff-4ac0-9c74-3118edfd9747',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Ftrees_badge_hero.svg?alt=media&token=7338baa7-9813-489a-bf0d-7ba822b4fd67',
  ),
  ocean(
    title: 'Plastic Free',
    description: 'Oceans are polluted with plastics. Cleaning them helps marine life thrive.',
    instruction1: 'Use your finger or mouse to move the ship and aim to shoot micro-plastics.',
    instruction2: 'Earn 1 point for each plastic shot in 30 seconds.',
    instructionAsset1: AssetPaths.infoPlastics1,
    instructionAsset2: AssetPaths.infoPlastics2,
    completedText: 'Your dedication to removing plastics\nkeeps our oceans clean and marine life safe.',
    routePath: OceanChallengeScreen.routePath,
    badgeAsset: AssetPaths.oceanBadge,
    badgeTitle: 'Ocean Protector',
    badgeDescription: 'Your dedication to removing plastics keeps our oceans clean and marine life safe',
    badgeLogoUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Focean_badge.svg?alt=media&token=37884bd4-ba2d-4164-a8e0-f64a83cfbb5e',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Focean_badge_hero.svg?alt=media&token=3c32d76b-f6ee-4240-ba97-e3bb75bda74c',
  ),
  lightsOut(
    title: 'Lights Out Challenge',
    description: 'Turning off lights saves power and protects wildlife.',
    instruction1: 'Tap to make Eco jump and switch off lights to reduce energy waste.',
    instruction2: 'Turn off as many lights as you can in 30 seconds and earn points.',
    completedText: 'Your action in reducing light pollution\n helps save energy and protect nocturnal wildlife.',
    routePath: LightsOutChallengeScreen.routePath,
    instructionAsset1: AssetPaths.infoLightsOut1,
    instructionAsset2: AssetPaths.infoTimer,
    badgeAsset: AssetPaths.lightsOffBadge,
    badgeTitle: 'Carbon footprint',
    badgeDescription: 'Your action in reducing light pollution helps save energy and protect nocturnal wildlife.',
    badgeLogoUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Flights_off_badge.svg?alt=media&token=6b7347e2-277b-4690-8e52-01f82692f074',
    badgeUrl:
        'https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Flights_off_badge_hero.svg?alt=media&token=0d66abb8-7be2-411f-a64d-d5a436d3647e',
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
