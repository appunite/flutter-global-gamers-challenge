enum EcoTextBubbleType {
  ecoIntroduction(
    text:
        'Welcome to Better World! My name is Eco! I need your help to clean our World and to be more sustainable! It\'s clouded by pollution.',
  ),
  mapIntroduction(
      text:
          'Each pin on the map hides a challenge to clean that area! Each successful game earns you points and improves our World environment!'),
  challengeIntroduction(
      text:
          'Replay challenges anytime to beat your score and improve your environmental impact! Tap the pin to start!'),
  allChallengesCompleted(text: 'TODO');

  const EcoTextBubbleType({required this.text});

  final String text;
}
