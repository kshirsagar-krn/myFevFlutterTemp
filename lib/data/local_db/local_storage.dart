import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveLocalStorage {
  static late Box _box;
  static bool _isInitialized = false;

  // Initialize Hive
  static Future<void> init() async {
    if (!_isInitialized) {
      final appDocumentDirectory = await path_provider
          .getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
      _box = await Hive.openBox('app_storage');
      _isInitialized = true;
    }
  }

  // Write any data
  static Future<void> write(String key, dynamic value) async {
    await init();
    await _box.put(key, value);
  }

  // Read any data
  static dynamic read(String key) {
    if (!_isInitialized) {
      throw Exception('HiveLocalStorage not initialized. Call init() first.');
    }
    return _box.get(key);
  }

  // Check if key exists
  static bool containsKey(String key) {
    if (!_isInitialized) {
      throw Exception('HiveLocalStorage not initialized. Call init() first.');
    }
    return _box.containsKey(key);
  }

  // Delete data
  static Future<void> delete(String key) async {
    await init();
    await _box.delete(key);
  }

  // Clear all data
  static Future<void> clear() async {
    await init();
    await _box.clear();
  }

  // Get all keys
  static List<String> getKeys() {
    if (!_isInitialized) {
      throw Exception('HiveLocalStorage not initialized. Call init() first.');
    }
    return _box.keys.cast<String>().toList();
  }

  // Close Hive
  static Future<void> close() async {
    if (_isInitialized) {
      await _box.close();
      _isInitialized = false;
    }
  }

  // ----------------------------------------------------------
  // 🔥  MAP CRUD OPERATIONS (Map<String, dynamic>)
  // ----------------------------------------------------------

  /// Create or overwrite entire map
  static Future<void> mapCreate(String key, Map<String, dynamic> data) async {
    await init();
    await _box.put(key, data);
  }

  /// Read map safely
  static Map<String, dynamic> mapRead(String key) {
    if (!_isInitialized) {
      throw Exception('HiveLocalStorage not initialized. Call init() first.');
    }
    return Map<String, dynamic>.from(_box.get(key, defaultValue: {}) ?? {});
  }

  /// Update map (modify only specific fields)
  static Future<void> mapUpdate(
    String key,
    Map<String, dynamic> updates,
  ) async {
    await init();
    Map<String, dynamic> existing = mapRead(key);
    existing.addAll(updates);
    await _box.put(key, existing);
  }

  /// Delete a specific field inside the map
  static Future<void> mapDeleteField(String key, String fieldKey) async {
    await init();
    Map<String, dynamic> existing = mapRead(key);
    existing.remove(fieldKey);
    await _box.put(key, existing);
  }

  /// Clear only map value (not whole box)
  static Future<void> mapClear(String key) async {
    await init();
    await _box.put(key, {});
  }
}
