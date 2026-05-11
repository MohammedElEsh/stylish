import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class StorageService {
  static const String _boxName = 'app_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(_boxName);
  }

  static Future<void> write(String key, dynamic value) async {
    final box = Hive.box<dynamic>(_boxName);
    await box.put(key, value);
  }

  static dynamic read(String key) {
    final box = Hive.box<dynamic>(_boxName);
    return box.get(key);
  }

  static Future<void> delete(String key) async {
    final box = Hive.box<dynamic>(_boxName);
    await box.delete(key);
  }

  static Future<void> clear() async {
    final box = Hive.box<dynamic>(_boxName);
    await box.clear();
  }
}
