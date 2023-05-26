import 'package:radon_app/models/user_logger.dart';
import 'package:radon_app/services/api_service.dart';

class UserLoggerRepository {
  final ApiService _apiService = ApiService();

  Future<UserLogger> create(int userId, String loggerId, String loggerPassword) async {
    final body = {
      'userId': userId,
      'loggerId': loggerId,
      'loggerPassword': loggerPassword,
    };

    final response = await _apiService.post('userlogger/create', body);
    return UserLogger.fromJson(response["data"]);
  }
}