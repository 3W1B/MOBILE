import 'package:radon_app/services/api_service.dart';

import '../models/user.dart';

class UserRepository {
  final ApiService _apiService = ApiService();

  Future<User> register(String email, String password, String firstName, String lastName, String phone) async {
    final body = {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };

    final response = await _apiService.post('user/register', body);
    return User.fromJson(response["data"]);
  }

  Future<User> login(String email, String password) async {
    final body = {
      'email': email,
      'password': password,
    };

    final response = await _apiService.post('user/login', body);
    return User.fromJson(response["data"]);
  }
}