import 'package:hive_flutter/adapters.dart';

class HiveManager {
  static late Box<dynamic> _myBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _myBox = await Hive.openBox('myBox');
  }

  static Box<dynamic> get myBox => _myBox;
}
