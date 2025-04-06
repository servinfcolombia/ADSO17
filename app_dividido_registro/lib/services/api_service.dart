import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.10.31.191:8000';

  // Registrar credenciales de login
  static Future<Map<String, dynamic>> registerLoginCredentials({
    required String email,
    required String password,
  }) async {
    final Uri url = Uri.parse('$baseUrl/register-login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(responseData['detail'] ?? 'Unknown error occurred');
      }

      return {'statusCode': response.statusCode, 'data': responseData};
    } catch (e) {
      throw Exception('Failed to register credentials: ${e.toString()}');
    }
  }

  // Verificar credenciales de login
  static Future<Map<String, dynamic>> verifyLoginCredentials({
    required String email,
    required String password,
  }) async {
    final Uri url = Uri.parse('$baseUrl/verify-login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(responseData['detail'] ?? 'Invalid credentials');
      }

      return {'statusCode': response.statusCode, 'data': responseData};
    } catch (e) {
      throw Exception('Login verification failed: ${e.toString()}');
    }
  }

  static login(String email, String password) {}
}
