import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.10.31.191:8000';

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final Uri url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      responseData['statusCode'] = response.statusCode;
      return responseData;
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
