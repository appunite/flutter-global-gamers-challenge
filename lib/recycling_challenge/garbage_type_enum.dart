import 'package:endless_runner/recycling_challenge/dumpster_widget.dart';
import 'dart:math' as math;

const _recyclingImagePath = 'assets/images/recycling/';

enum GarbageType {
  banana(
    assetPath: '${_recyclingImagePath}banana.png',
    semanticLabel: 'banana',
    dumpsterType: DumpsterType.other,
  ),
  apple(
    assetPath: '${_recyclingImagePath}apple.png',
    semanticLabel: 'apple',
    dumpsterType: DumpsterType.other,
    rotationAngle: math.pi / 10,
  ),
  diaper(
    assetPath: '${_recyclingImagePath}diaper.png',
    semanticLabel: 'diaper',
    dumpsterType: DumpsterType.other,
  ),
  glassBottle(
    assetPath: '${_recyclingImagePath}glass_bottle.png',
    semanticLabel: 'glass bottle',
    dumpsterType: DumpsterType.recyclable,
    size: 80,
  ),
  plasticBottle(
    assetPath: '${_recyclingImagePath}plastic_bottle.png',
    semanticLabel: 'plastic bottle',
    dumpsterType: DumpsterType.recyclable,
    rotationAngle: -math.pi / 6,
    size: 80,
  ),
  cardboard(
      assetPath: '${_recyclingImagePath}cardboard.png',
      semanticLabel: 'cardboard',
      dumpsterType: DumpsterType.recyclable),
  can(
    assetPath: '${_recyclingImagePath}can.png',
    semanticLabel: 'can',
    dumpsterType: DumpsterType.recyclable,
    rotationAngle: math.pi / 4,
  ),
  documents(
    assetPath: '${_recyclingImagePath}documents.png',
    semanticLabel: 'documents',
    dumpsterType: DumpsterType.recyclable,
    rotationAngle: -math.pi / 10,
    size: 70,
  ),
  lightbulb(
    assetPath: '${_recyclingImagePath}lightbulb.png',
    semanticLabel: 'lightbulb',
    dumpsterType: DumpsterType.other,
    rotationAngle: math.pi / 6,
  ),
  fishbones(
    assetPath: '${_recyclingImagePath}fishbones.png',
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
