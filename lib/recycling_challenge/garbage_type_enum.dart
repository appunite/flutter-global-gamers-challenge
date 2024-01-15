enum GarbageType {
  banana(
    assetPath: 'assets/images/recycling/banana.png',
    semanticLabel: 'banana',
    recyclable: false,
  ),
  apple(
    assetPath: 'assets/images/recycling/apple.png',
    semanticLabel: 'apple',
    recyclable: false,
  ),
  diaper(
    assetPath: 'assets/images/recycling/diaper.png',
    semanticLabel: 'diaper',
    recyclable: false,
  ),
  glassBottle(
    assetPath: 'assets/images/recycling/glass_bottle.png',
    semanticLabel: 'glassBottle',
    recyclable: true,
  ),
  plasticBottle(
    assetPath: 'assets/images/recycling/plastic_bottle.png',
    semanticLabel: 'plasticBottle',
    recyclable: true,
  ),
  cardboard(
    assetPath: 'assets/images/recycling/cardboard.png',
    semanticLabel: 'cardboard',
    recyclable: true,
  ),
  can(
    assetPath: 'assets/images/recycling/can.png',
    semanticLabel: 'can',
    recyclable: true,
  ),
  documents(
    assetPath: 'assets/images/recycling/documents.png',
    semanticLabel: 'documents',
    recyclable: true,
  ),
  lightbulb(
    assetPath: 'assets/images/recycling/lightbulb.png',
    semanticLabel: 'lightbulb',
    recyclable: false,
  ),
  fishbones(
    assetPath: 'assets/images/recycling/fishbones.png',
    semanticLabel: 'fishbones',
    recyclable: false,
  );

  const GarbageType({
    required this.assetPath,
    required this.semanticLabel,
    required this.recyclable,
  });

  final String assetPath;
  final String semanticLabel;
  final bool recyclable;
}
