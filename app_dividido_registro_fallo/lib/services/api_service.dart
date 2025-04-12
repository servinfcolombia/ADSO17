import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.10.31.147:8000';

  // Validacion de login
  // Esta función se encarga de enviar una solicitud POST al servidor para iniciar sesión.
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

  // Registrar usuario
  static Future<Map<String, dynamic>> register(
    String email,
    String password,
  ) async {
    final Uri url = Uri.parse('$baseUrl/register');

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

      // Check if the response is successful (status code 200)
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      responseData['statusCode'] = response.statusCode;
      return responseData;
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  // Eliminar usuario
  static Future<Map<String, dynamic>> deleteUser(String email) async {
    final Uri url = Uri.parse('$baseUrl/delete_user/$email');

    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      responseData['statusCode'] = response.statusCode;
      return responseData;
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  // Mostrar todos los usuarios
  static Future<Map<String, dynamic>> getUsers() async {
    final Uri url = Uri.parse('$baseUrl/users');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      responseData['statusCode'] = response.statusCode;
      return responseData;
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  // Mostrar todos los actualizar usuario
  static Future<Map<String, dynamic>> updateUser(
    String currentEmail,
    String newEmail,
    String newPassword,
  ) async {
    final Uri url = Uri.parse('$baseUrl/update_user');

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'current_email': currentEmail,
          'new_email': newEmail,
          'new_password': newPassword,
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
