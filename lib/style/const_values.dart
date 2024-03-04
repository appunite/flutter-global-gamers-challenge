import 'dart:io';

import 'package:better_world/common/asset_paths.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final BorderRadius borderRadius12 = BorderRadius.circular(12);
final BorderRadius borderRadius16 = BorderRadius.circular(16);
final BorderRadius borderRadius24 = BorderRadius.circular(24);
final BorderRadius borderRadius32 = BorderRadius.circular(32);

bool displayAdditionalPadding = kIsWeb || Platform.isMacOS || Platform.isAndroid;

const gameCompletedBadgeTitle = 'World Hero';
const gameCompletedBadgeDescription =
    'You\'ve generated clean energy, conserved water, reduced light pollution, grown green spaces, and boosted recycling!';
const gameCompletedBadgeAsset = AssetPaths.worldHeroBadge;
const gameCompletedLogoUrl =
    "https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2FBadges-5.jpg?alt=media&token=4737dea8-97b4-49e5-8f22-747554cb942b";
const gameCompletedBadgeUrl =
    "https://firebasestorage.googleapis.com/v0/b/flutter-game-challenge.appspot.com/o/badges%2Fnew_badges%2Fwallet_badge_05.png?alt=media&token=b780f8dc-2cdb-4771-adbb-f1668857532e";
