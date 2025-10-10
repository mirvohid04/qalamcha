import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

class LocalStorageService {
  static const String _userKey = "user";

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(user.toJson());
    await prefs.setString(_userKey, json);
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_userKey);
    if (json != null) {
      return UserModel.fromJson(jsonDecode(json));
    }
    return null;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
