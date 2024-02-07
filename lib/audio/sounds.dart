List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.jump:
      return const [
        'jump.mp3',
      ];
    case SfxType.hit:
      return const [
        'hit1.mp3',
        'hit2.mp3',
      ];
    case SfxType.damage:
      return const [
        'damage1.mp3',
        'damage2.mp3',
      ];
    case SfxType.score:
      return const [
        'lamp_point.mp3',
      ];
    case SfxType.buttonTap:
      return const [
        'click1.mp3',
        'click2.mp3',
        'click3.mp3',
        'click4.mp3',
      ];
    case SfxType.garbage:
      return const ['garbage.mp3'];
    case SfxType.wrongBin:
      return const ['wrong_bin.mp3'];
    case SfxType.microplasticDestroyed:
      return const ['microplasticDestroyed.mp3'];
    case SfxType.shoot:
      return const ['shoot.mp3'];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.jump:
    case SfxType.damage:
    case SfxType.hit:
    case SfxType.garbage:
    case SfxType.shoot:
    case SfxType.microplasticDestroyed:
    case SfxType.wrongBin:
      return 0.4;

    case SfxType.buttonTap:
      return 1.0;
    case SfxType.score:
      return 2.0;
  }
}

enum SfxType {
  score,
  jump,
  hit,
  damage,
  buttonTap,
  garbage,
  wrongBin,
  microplasticDestroyed,
  shoot,
}
