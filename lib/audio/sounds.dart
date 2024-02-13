List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.jump:
      return const [
        'jump.mp3',
      ];

    case SfxType.score:
      return const [
        'lamp_point.mp3',
      ];
    case SfxType.buttonTap:
      return const ['click.mp3'];
    case SfxType.garbage:
      return const ['garbage.mp3'];
    case SfxType.wrongBin:
      return const ['wrong_bin.mp3'];
    case SfxType.microplasticDestroyed:
      return const ['microplastic_destroyed.mp3'];
    case SfxType.shoot:
      return const ['shoot.mp3'];
    case SfxType.pipe:
      return const ['pipe.mp3'];
    case SfxType.fireworks:
      return const ['fireworks_short.mp3'];
    case SfxType.challengeSuccessful:
      return const ['challenge_successful.mp3'];
    case SfxType.challengeUnsuccessful:
      return const ['challenge_unsuccessful.mp3'];
    case SfxType.countdown:
      return const ['countdown.mp3'];
    case SfxType.panelCleaning:
      return const ['cleaning_window.mp3'];
    case SfxType.waterInPipe:
      return const ['water_pipe.mp3'];
    case SfxType.pipeWheel:
      return const ['pipe_wheel.mp3'];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.jump:
    case SfxType.garbage:
    case SfxType.shoot:
    case SfxType.microplasticDestroyed:
    case SfxType.wrongBin:
    case SfxType.panelCleaning:
    case SfxType.countdown:
    case SfxType.pipe:
    case SfxType.pipeWheel:
      return 0.4;
    case SfxType.buttonTap:
    case SfxType.challengeSuccessful:
    case SfxType.challengeUnsuccessful:
    case SfxType.fireworks:
      return 1.0;
    case SfxType.waterInPipe:
    case SfxType.score:
      return 2.0;
  }
}

enum SfxType {
  score,
  jump,
  buttonTap,
  garbage,
  wrongBin,
  microplasticDestroyed,
  shoot,
  challengeSuccessful,
  challengeUnsuccessful,
  pipe,
  fireworks,
  countdown,
  panelCleaning,
  waterInPipe,
  pipeWheel,
}
