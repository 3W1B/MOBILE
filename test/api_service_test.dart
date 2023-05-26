import 'package:flutter_test/flutter_test.dart';
import 'package:radon_app/services/api_service.dart';
import 'package:uuid/uuid.dart';


void main() {
  group('API Service', () {

    final uuid = const Uuid().v4();

    test("Test should create a user in the db", () async {
      const path = "user/register";
      final body = {
        "email": uuid,
        "password": "password",
        "firstName": "flutterFirst",
        "lastName": "flutterLast",
        "phone": uuid
      };

      final apiService = ApiService();
      final data = await apiService.post(path, body);
      expect(data['status'], 'success');
    });
  });
}