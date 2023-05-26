import 'package:radon_app/models/logger.dart';
import 'package:radon_app/services/api_service.dart';

class LoggerRepository {
  final ApiService _apiService = ApiService();

  Future<Logger> read(String id, String password) async {
    final body = {
      'id': id,
      'password': password,
    };

    final response = await _apiService.post('logger/read', body);
    return Logger.fromJson(response["data"]);
  }
}