import 'package:check_inspecao_app/app/config/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsStorage implements IStorage {
  final SharedPreferences _preferences;

  PrefsStorage(this._preferences);

  @override
  void clear() {
    _preferences.clear();
  }

  @override
  String? fetch(String key) {
    return _preferences.getString(key);
  }

  @override
  void save(String key, value) {
    _preferences.setString(key, value);
  }
}
