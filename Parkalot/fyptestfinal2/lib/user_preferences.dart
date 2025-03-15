import 'package:hive/hive.dart';

class UserPreferences {
  // Open a box for storing user data
  static Future<Box> _openBox() async {
    return await Hive.openBox('userBox');
  }

  // Function to get userId from Hive
  static Future<int> getUserId() async {
    var box = await _openBox();
    return box.get('userId',
        defaultValue: 0); // Default 0 if userId is not found
  }

  // Function to save userId to Hive
  static Future<void> saveUserId(int userId) async {
    var box = await _openBox();
    await box.put('userId', userId);
    print('User ID saved globally: $userId');
  }
}
