enum ChallengeType {
  pipelines(
    title: 'Pipeline Puzzle',
    description: 'Clean water is vital. Fixing pipelines prevents pollution and saves water.',
    instruction1: 'Connect pipes correctly to stop leaks.',
    instruction2: 'Score 1 point for each correct fix for 10 seconds.',
    completedText:
        'By fixing leaky pipelines, you\'ve helped conserve water\nand protect aquatic ecosystems in Better World.',
  ),
  recycling(
    title: 'Recycle Rush',
    description: 'Proper recycling reduces waste. Let\'s sort recyclables correctly!',
    instruction1: 'Drag items to the right bins. Accurate sorting counts!',
    instruction2: 'Get 1 point for each item correctly sorted in 10 seconds.',
    completedText: 'Your recycling skills are key\n to reducing waste and conserving resources.',
  ),
  solarPanel(
    title: 'Solar Panel Cleanup',
    description: 'Solar panels convert sunlight into electricity. When dirty, efficiency drops.',
    instruction1: 'Scratch the screen to clean and increase solar energy output.',
    instruction2: 'Clean as many panels as you can in 3 seconds and earn points.',
    completedText: 'You\'ve cleaned the solar panels,\nincreasing the city\'s energy efficiency!',
  ),
  trees(
    title: 'Plant a Forest',
    description: 'Trees combat climate change and increase biodiversity.',
    instruction1: 'Tap the button to plant a tree and help restore nature\'s balance.',
    instruction2: 'Get 1 point for each planted tree and combat deforestation.',
    completedText: 'Thanks to your tree planting,\nBetter World breathes easier with increased green cover.',
  ),
  ocean(
    title: 'Plastic Free',
    description: 'Oceans are polluted with plastics. Cleaning them helps marine life thrive.',
    instruction1: 'Aim and shoot at micro-plastics to clean the underwater.',
    instruction2: 'Earn 1 point for each plastic removed during 10 seconds.',
    completedText: 'Your dedication to removing plastics\nkeeps our oceans clean and marine life safe.',
  ),
  city(
    title: 'Lights Out Challenge',
    description: 'Turning off lights saves power and protects wildlife.',
    instruction1: 'Tap buildings to turn off lights and reduce energy waste.',
    instruction2: 'Turn off as many lights as you can in 10 seconds and earn points.',
    completedText: 'Your action in reducing light pollution\n helps save energy and protect nocturnal wildlife.',
  );

  const ChallengeType({
    required this.title,
    required this.description,
    required this.instruction1,
    required this.instruction2,
    required this.completedText,
  });

  final String title;
  final String description;
  final String instruction1;
  final String instruction2;
  final String completedText;
}
