import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  static const String memeKey = "MEMEKEY";

  static Future<bool> saveData(int val) async {
    final inst = await SharedPreferences.getInstance();
    return await inst.setInt(memeKey, val);
  }

  static Future<int?> fetchData() async {
    final inst = await SharedPreferences.getInstance();
    return inst.getInt(memeKey);
  }
}
