import 'package:endless_runner/common/asset_paths.dart';
import 'package:endless_runner/challenges/recycling_challenge/dumpster_widget.dart';
import 'dart:math' as math;

enum GarbageType {
  banana(
    assetPath: AssetPaths.bananaPeel,
    semanticLabel: 'banana peel',
    dumpsterType: DumpsterType.other,
  ),
  apple(
    assetPath: AssetPaths.appleCore,
    semanticLabel: 'apple core',
    dumpsterType: DumpsterType.other,
    rotationAngle: math.pi / 10,
  ),
  diaper(
    assetPath: AssetPaths.diaper,
    semanticLabel: 'diaper',
    dumpsterType: DumpsterType.other,
  ),
  glassBottle(
    assetPath: AssetPaths.glassBottle,
    semanticLabel: 'glass bottle',
    dumpsterType: DumpsterType.recyclable,
    size: 80,
  ),
  plasticBottle(
    assetPath: AssetPaths.plasticBottle,
    semanticLabel: 'plastic bottle',
    dumpsterType: DumpsterType.recyclable,
    rotationAngle: -math.pi / 6,
    size: 80,
  ),
  cardboard(
    assetPath: AssetPaths.cardboard,
    semanticLabel: 'cardboard',
    dumpsterType: DumpsterType.recyclable,
  ),
  can(
    assetPath: AssetPaths.can,
    semanticLabel: 'can',
    dumpsterType: DumpsterType.recyclable,
    rotationAngle: math.pi / 4,
  ),
  documents(
    assetPath: AssetPaths.documents,
    semanticLabel: 'documents',
    dumpsterType: DumpsterType.recyclable,
    rotationAngle: -math.pi / 10,
    size: 70,
  ),
  lightbulb(
    assetPath: AssetPaths.lightbulb,
    semanticLabel: 'lightbulb',
    dumpsterType: DumpsterType.other,
    rotationAngle: math.pi / 6,
  ),
  fishbones(
    assetPath: AssetPaths.fishbones,
    semanticLabel: 'fishbones',
    dumpsterType: DumpsterType.other,
    rotationAngle: -math.pi / 6,
  );

  const GarbageType({
    required this.assetPath,
    required this.semanticLabel,
    required this.dumpsterType,
    this.rotationAngle = 0,
    this.size = 60,
  });

  final String assetPath;
  final String semanticLabel;
  final DumpsterType dumpsterType;
  final double rotationAngle;
  final double size;
}
