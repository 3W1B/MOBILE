import 'dart:convert';

import 'package:http/http.dart' as http;


class ApiService {

  static const String _url = 'http://128.140.9.68:5001/';

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    final http.Response response = await http.post(
      Uri.parse(_url + path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data["status"] == "success") {
        return data;
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}