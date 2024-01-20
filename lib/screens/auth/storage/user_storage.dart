import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/auth/models/user_model.dart';

class UserStorage {
  static const String _userKey = 'me';

  static Future<void> saveUser(UserModel user) async {
    final box = GetStorage();
    await box.write(_userKey, user.toJson());
  }

  static Future<void> saveToken(String token) async {
    final box = GetStorage();
    await box.write('token', token);
  }

  static UserModel? getUser() {
    final box = GetStorage();
    final userData = box.read(_userKey);
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }

  static String? getToken() {
    final box = GetStorage();
    final token = box.read('token');
    return token;
  }

  static Future<void> removeUser() async {
    final box = GetStorage();
    await box.remove(_userKey);
  }

  static Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove('token');
  }
}
