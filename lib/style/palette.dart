import 'package:flame/palette.dart';

class Palette {
  static const primary = Color(0xFF15BB28);
  static const primaryDark = Color(0xFF16973D);
  static const primaryLight = Color(0xFFE7F6ED);
  static const primaryProgress = Color(0xFFB6EABC);

  static const secondary = Color(0xFF28AEFB);
  static const secondaryDark = Color(0xFF2D67D7);
  static const secondaryLight = Color(0xFFF0F5FF);

  static const accent = Color(0xFFFDDF76);
  static const accentDark = Color(0xFFD7A72D);
  static const accentLight = Color(0xFFFEF2C7);
  static const accentSkeleton = Color.fromARGB(255, 248, 232, 176);
  static const accentBackground = Color(0xFFF19D3A);

  static const neutralWhite = Color(0xFFFFFCFE);
  static const neutralBlack = Color(0xFF212121);
  static const neutralLightBlack = Color(0xFF8F919B);
  static const neutralDarkGray = Color(0xFFD0D3E0);
  static const neutralLightGray = Color(0xFFEBECF2);
  static const neutralBeige = Color(0xFFFFF6E8);
  static const lightsOutBackground = Color(0xFFD7CBC1);
  static const error = Color(0xFFBB3A29);
  static Color overlay = const Color(0xFF14315C).withOpacity(.6);

  static const buttonTextColor = neutralWhite;
}
