import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LocalPlayerPersistence {
  LocalPlayerPersistence({required this.sharedPrefs});

  final Future<SharedPreferences> sharedPrefs;

  static const _playerIdKey = 'playerIdKey';

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
}
