import 'dart:math' as math;

import 'package:endless_runner/challenges/recycling_challenge/bin_widget.dart';
import 'package:endless_runner/common/asset_paths.dart';

enum GarbageType {
  banana(
    assetPath: AssetPaths.bananaPeel,
    semanticLabel: 'banana peel',
    dumpsterType: BinType.organic,
  ),
  apple(
    assetPath: AssetPaths.apple,
    semanticLabel: 'apple core',
    dumpsterType: BinType.organic,
    rotationAngle: math.pi / 12,
    size: 45,
  ),
  bag(
    assetPath: AssetPaths.bag,
    semanticLabel: 'bag',
    dumpsterType: BinType.plasticMetal,
    size: 40,
  ),
  bigWater(
    assetPath: AssetPaths.bigWater,
    semanticLabel: 'big water bottle',
    dumpsterType: BinType.plasticMetal,
    size: 90,
    rotationAngle: -math.pi / 2,
  ),
  bread(
    assetPath: AssetPaths.bread,
    semanticLabel: 'bread',
    dumpsterType: BinType.organic,
    rotationAngle: math.pi / 2,
    size: 90,
  ),
  canOrange(
    assetPath: AssetPaths.canOrange,
    semanticLabel: 'orange can',
    dumpsterType: BinType.plasticMetal,
    rotationAngle: -math.pi / 12,
  ),
  canPink(
    assetPath: AssetPaths.canPink,
    semanticLabel: 'pink can',
    dumpsterType: BinType.plasticMetal,
    rotationAngle: math.pi,
  ),
  can(
    assetPath: AssetPaths.canSmall,
    semanticLabel: 'can',
    dumpsterType: BinType.plasticMetal,
    size: 50,
  ),
  fishbones(
    assetPath: AssetPaths.fishbones,
    semanticLabel: 'fishbones',
    dumpsterType: BinType.organic,
    size: 60,
  ),
  glassBottle(
    assetPath: AssetPaths.glassBottle,
    semanticLabel: 'glass bottle',
    dumpsterType: BinType.glass,
    rotationAngle: math.pi / 6,
    size: 85,
  ),
  glassJar(
    assetPath: AssetPaths.glassJar,
    semanticLabel: 'glass jar',
    dumpsterType: BinType.glass,
    rotationAngle: math.pi / 2,
    size: 70,
  ),
  glass(
    assetPath: AssetPaths.glass,
    semanticLabel: 'glass',
    dumpsterType: BinType.glass,
    rotationAngle: -math.pi / 12,
    size: 45,
  ),
  metalCan(
    assetPath: AssetPaths.metalCan,
    semanticLabel: 'metal can',
    dumpsterType: BinType.plasticMetal,
    size: 55,
  ),
  packaging(
    assetPath: AssetPaths.packaging,
    semanticLabel: 'packaging',
    dumpsterType: BinType.paper,
    rotationAngle: -math.pi / 3,
  ),
  plasticBox(
    assetPath: AssetPaths.plasticBox,
    semanticLabel: 'plastic box',
    dumpsterType: BinType.plasticMetal,
    size: 95,
  ),
  paper(
    assetPath: AssetPaths.paper,
    semanticLabel: 'paper',
    dumpsterType: BinType.paper,
  ),
  plasticBag(
    assetPath: AssetPaths.plasticBag,
    semanticLabel: 'plastic bag',
    dumpsterType: BinType.plasticMetal,
    size: 70,
  ),
  waterBottle(
    assetPath: AssetPaths.waterBottle,
    semanticLabel: 'water bottle',
    dumpsterType: BinType.plasticMetal,
    rotationAngle: -math.pi / 2,
    size: 70,
  ),
  watermelon(
    assetPath: AssetPaths.watermelon,
    semanticLabel: 'watermelon',
    dumpsterType: BinType.organic,
    rotationAngle: math.pi / 2,
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
  final BinType dumpsterType;
  final double rotationAngle;
  final double size;
}
