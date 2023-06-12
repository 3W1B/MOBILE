import 'package:radon_app/utils/json_file_manager.dart';

abstract class UserHandler {
  static remember({required String email, required String password}) async {
    dynamic loginInfo = await JsonFileManager.read('login-info');
    if (loginInfo != null) {
      await JsonFileManager.delete('login-info');
    }
    await JsonFileManager.create(
      {
        'login-info': {
          'email': email,
          'password': password,
        }
      },
    );
  }

  static logout() async {
    await JsonFileManager.delete('login-info');
  }

  static getRemembered() async {
    dynamic loginInfo = await JsonFileManager.read('login-info');
    return loginInfo;
  }
}
