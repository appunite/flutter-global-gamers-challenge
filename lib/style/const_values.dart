import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final BorderRadius borderRadius12 = BorderRadius.circular(12);
final BorderRadius borderRadius16 = BorderRadius.circular(16);
final BorderRadius borderRadius24 = BorderRadius.circular(24);
final BorderRadius borderRadius32 = BorderRadius.circular(32);

bool displayAdditionalPadding = kIsWeb || Platform.isMacOS || Platform.isAndroid;
