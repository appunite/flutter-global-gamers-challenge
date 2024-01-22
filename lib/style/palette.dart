import 'package:flame/palette.dart';

class Palette {
  PaletteEntry get seed => const PaletteEntry(Color(0xFF0050bc));
  PaletteEntry get text => const PaletteEntry(Color(0xee352b42));
  PaletteEntry get backgroundMain => const PaletteEntry(Color(0xffa2fff3));
  PaletteEntry get backgroundLevelSelection => const PaletteEntry(Color(0xffffcd75));
  PaletteEntry get backgroundPlaySession => const PaletteEntry(Color(0xffa2fff3));
  PaletteEntry get backgroundSettings => const PaletteEntry(Color(0xffbfc8e3));

  /// our colors
  static const primary = Color(0xFF15BB28);
  static const primaryDark = Color(0xFF16973D);
  static const primaryLight = Color(0xFFE7F6ED);

  static const secondary = Color(0xFF28AEFB);
  static const secondaryDark = Color(0xFF2D67D7);
  static const secondaryLight = Color(0xFFF0F5FF);

  static const neutralWhite = Color(0xFFFFFCFE);

  static const buttonTextColor = neutralWhite;
}
