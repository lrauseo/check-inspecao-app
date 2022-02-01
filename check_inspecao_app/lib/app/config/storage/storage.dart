abstract class IStorage {
  void save(String key, dynamic value);
  String? fetch(String key);
  void clear();
}

class Storage<T> {
  IStorage _source;

  Storage(this._source);

  get storage => this._source;

  void save(String key, T value) async => await this.storage.save(key, value);

  T fetch(String key) => this.storage.fetch(key);

  void clear() async => await this.storage.clear();
}
