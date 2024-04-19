// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'persistence/local_storage_settings_persistence.dart';
import 'persistence/settings_persistence.dart';

class SettingsController {
  SettingsController({SettingsPersistence? store}) : _store = store ?? LocalStorageSettingsPersistence() {
    _loadSettings();
  }

  final SettingsPersistence _store;

  ValueNotifier<bool> audioOn = ValueNotifier(true);

  ValueNotifier<bool> soundsOn = ValueNotifier(true);

  ValueNotifier<bool> musicOn = ValueNotifier(true);

  void toggleAudioOn() {
    audioOn.value = !audioOn.value;
    _store.saveAudioOn(audioOn.value);
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    _store.saveMusicOn(musicOn.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _store.saveSoundsOn(soundsOn.value);
  }

  Future<void> _loadSettings() async {
    await Future.wait([
      _store.getAudioOn(defaultValue: true).then((value) => audioOn.value = value),
      _store.getSoundsOn(defaultValue: true).then((value) => soundsOn.value = value),
      _store.getMusicOn(defaultValue: true).then((value) => musicOn.value = value),
    ]);
  }
}
