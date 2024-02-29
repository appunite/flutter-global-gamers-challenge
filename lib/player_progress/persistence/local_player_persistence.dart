import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalPlayerPersistence {
  LocalPlayerPersistence({required this.sharedPrefs});

  final Future<SharedPreferences> sharedPrefs;

  static const _playerIdKey = 'playerIdKey';
  static const _hasSeenOnboardingKey = 'hasSeenOnboardingKey';
  static const _hasSeenGameCompletedCongratsKey = 'hasSeenGameCompletedCongratsKey';

  Future<String> getPlayerIdKey() async {
    final instance = await sharedPrefs;
    return instance.getString(_playerIdKey) ?? await _generatePlayerId();
  }

  Future<String> _generatePlayerId() async {
    final newPlayerId = const Uuid().v4();
    final instance = await sharedPrefs;
    await instance.setString(_playerIdKey, newPlayerId);
    return newPlayerId;
  }

  Future<bool> getHasSeenOnboarding() async {
    final instance = await sharedPrefs;
    return instance.getBool(_hasSeenOnboardingKey) ?? false;
  }

  Future<void> setHasSeenOnboarding() async {
    final instance = await sharedPrefs;
    await instance.setBool(_hasSeenOnboardingKey, true);
  }

  Future<bool> getHasSeenGameCompletedCongrats() async {
    final instance = await sharedPrefs;
    return instance.getBool(_hasSeenGameCompletedCongratsKey) ?? false;
  }

  Future<void> setHasSeenGameCompletedCongrats({bool hasSeen = true}) async {
    final instance = await sharedPrefs;
    await instance.setBool(_hasSeenGameCompletedCongratsKey, hasSeen);
  }
}
