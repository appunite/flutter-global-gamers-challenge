import 'dart:math';

import 'package:endless_runner/common/asset_paths.dart';

enum MicroplasticTypeEnum {
  mp1(
    assetPath: AssetPaths.microplastic1,
    size: 74,
  ),
  mp2(
    assetPath: AssetPaths.microplastic2,
    size: 99,
  ),
  mp3(
    assetPath: AssetPaths.microplastic3,
    size: 30,
  ),
  mp4(
    assetPath: AssetPaths.microplastic4,
    size: 117,
  ),
  mp5(
    assetPath: AssetPaths.microplastic5,
    size: 86,
  ),
  mp6(
    assetPath: AssetPaths.microplastic6,
    size: 50,
  ),
  mp7(
    assetPath: AssetPaths.microplastic7,
    size: 38,
  ),
  mp8(
    assetPath: AssetPaths.microplastic8,
    size: 50,
  ),
  mp9(
    assetPath: AssetPaths.microplastic9,
    size: 74,
  ),
  mp10(
    assetPath: AssetPaths.microplastic10,
    size: 30,
  ),
  mp11(
    assetPath: AssetPaths.microplastic11,
    size: 30,
  ),
  mp12(
    assetPath: AssetPaths.microplastic12,
    size: 30,
  ),
  mp13(
    assetPath: AssetPaths.microplastic13,
    size: 30,
  ),
  mp14(
    assetPath: AssetPaths.microplastic14,
    size: 30,
  ),
  mp15(
    assetPath: AssetPaths.microplastic15,
    size: 30,
  ),
  mp16(
    assetPath: AssetPaths.microplastic16,
    size: 30,
  ),
  mp17(
    assetPath: AssetPaths.microplastic17,
    size: 73,
  ),
  mp18(
    assetPath: AssetPaths.microplastic18,
    size: 44,
  ),
  mp19(
    assetPath: AssetPaths.microplastic19,
    size: 44,
  ),
  mp20(
    assetPath: AssetPaths.microplastic20,
    size: 72,
  );

  const MicroplasticTypeEnum({
    required this.assetPath,
    required this.size,
  });

  final String assetPath;
  final double size;

  static MicroplasticTypeEnum random() {
    List<MicroplasticTypeEnum> enumValues = MicroplasticTypeEnum.values;
    Random random = Random();
    int randomIndex = random.nextInt(enumValues.length);
    MicroplasticTypeEnum randomEnumValue = enumValues[randomIndex];

    return randomEnumValue;
  }
}
