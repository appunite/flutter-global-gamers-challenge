import 'package:endless_runner/challenges/ocean_shooter/ocean_challenge_screen.dart';
import 'package:endless_runner/challenges/pipes_challenge/pipes_challenge_screen.dart';
import 'package:endless_runner/challenges/recycling_challenge/recycling_challenge_screen.dart';
import 'package:endless_runner/challenges/solar_panel_scratcher_challenge/solar_panel_scratcher_screen.dart';
import 'package:endless_runner/challenges/trees_challenge/trees_challenge_screen.dart';
import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/player_progress/entities/challenges_entity.dart';

enum ChallengeType {
  pipelines(
    title: 'Pipeline Puzzle',
    description: 'Clean water is vital. Fixing pipelines prevents pollution and saves water.',
    instruction1: 'Connect pipes correctly to stop leaks.',
    instruction2: 'Score 1 point for each correct fix for 10 seconds.',
    instructionAsset1: AssetPaths.infoPipes1,
    instructionAsset2: AssetPaths.infoPipes2,
    completedText:
        'By fixing leaky pipelines, you\'ve helped conserve water\nand protect aquatic ecosystems in Better World.',
    routePath: PipesChallengeScreen.routePath,
  ),
  recycling(
    title: 'Recycle Rush',
    description: 'Proper recycling reduces waste. Let\'s sort recyclables correctly!',
    instruction1: 'Drag items to the right bins. Accurate sorting counts!',
    instruction2: 'Get 1 point for each item correctly sorted in 10 seconds.',
    instructionAsset1: AssetPaths.infoRecycle1,
    instructionAsset2: AssetPaths.infoRecycle2,
    completedText: 'Your recycling skills are key\n to reducing waste and conserving resources.',
    routePath: RecyclingChallengeScreen.routePath,
  ),
  solarPanel(
    title: 'Solar Panel Cleanup',
    description: 'Solar panels convert sunlight into electricity. When dirty, efficiency drops.',
    instruction1: 'Scratch the screen to clean and increase solar energy output.',
    instruction2: 'Clean as many panels as you can in 3 seconds and earn points.',
    completedText: 'You\'ve cleaned the solar panels,\nincreasing the city\'s energy efficiency!',
    routePath: SolarPanelChallengeScreen.routePath,
  ),
  trees(
    title: 'Plant a Forest',
    description: 'Trees combat climate change and increase biodiversity.',
    instruction1: 'Tap the button to plant a tree and help restore nature\'s balance.',
    instruction2: 'Get 1 point for each planted tree and combat deforestation.',
    instructionAsset1: AssetPaths.infoTree1,
    instructionAsset2: AssetPaths.infoTree2,
    completedText: 'Thanks to your tree planting,\nBetter World breathes easier with increased green cover.',
    routePath: TreesChallengeScreen.routePath,
  ),
  ocean(
    title: 'Plastic Free',
    description: 'Oceans are polluted with plastics. Cleaning them helps marine life thrive.',
    instruction1: 'Aim and shoot at micro-plastics to clean the underwater.',
    instruction2: 'Earn 1 point for each plastic removed during 10 seconds.',
    completedText: 'Your dedication to removing plastics\nkeeps our oceans clean and marine life safe.',
    routePath: OceanChallengeScreen.routePath,
  ),
  city(
    title: 'Lights Out Challenge',
    description: 'Turning off lights saves power and protects wildlife.',
    instruction1: 'Tap buildings to turn off lights and reduce energy waste.',
    instruction2: 'Turn off as many lights as you can in 10 seconds and earn points.',
    completedText: 'Your action in reducing light pollution\n helps save energy and protect nocturnal wildlife.',
    routePath: 'TODO',
  );

  const ChallengeType({
    required this.title,
    required this.description,
    required this.instruction1,
    required this.instruction2,
    this.instructionAsset1,
    this.instructionAsset2,
    required this.completedText,
    required this.routePath,
  });

  final String title;
  final String description;
  final String instruction1;
  final String instruction2;
  //TODO required later
  final String? instructionAsset1;
  final String? instructionAsset2;
  final String completedText;
  final String routePath;

  int? getChallengeScore(ChallengesEntity challenges) {
    return switch (this) {
      ChallengeType.city => challenges.city,
      ChallengeType.ocean => challenges.ocean,
      ChallengeType.pipelines => challenges.pipes,
      ChallengeType.recycling => challenges.recycling,
      ChallengeType.solarPanel => challenges.solarPanel,
      ChallengeType.trees => challenges.trees,
    };
  }
}
