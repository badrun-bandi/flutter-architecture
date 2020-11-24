import 'base.model.dart';

class Translation extends BaseModel{
  final Map<String, dynamic> _translation;
  final Map<String, dynamic> _nestedKey;

  Translation(this._translation) : _nestedKey = {};

  String get(String key) =>
      (isNestedKey(key) ? getNested(key) : _translation[key]);

  String getNested(String key) {
    if (isNestedCached(key)) return _nestedKey[key];

    final keys = key.split('.');
    final kHead = keys.first;

    var value = _translation[kHead];

    for (var i = 1; i < keys.length; i++) {
      if (value is Map<String, dynamic>) value = value[keys[i]];
    }

    cacheNestedKey(key, value);
    return value;
  }

  // bool has(String key) => isNestedKey(key)
  //     ? getNested(key) != null
  //     : _translation.containsKey(key);

  bool isNestedCached(String key) => _nestedKey.containsKey(key);

  void cacheNestedKey(String key, String value) {
    if (!isNestedKey(key)) {
      throw Exception('Cannot cache a key that is not nested.');
    }
    _nestedKey[key] = value;
  }

  bool isNestedKey(String key) =>
      !_translation.containsKey(key) && key.contains('.');

  @override
  String toString() {
    return 'Translation{_translation: $_translation, _nestedKey: $_nestedKey}';
  }
}
