import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog(context, 'Por favor complete todos los campos');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.register(email, password);

      if (response['statusCode'] == 200) {
        _showSuccessDialog(
          context,
          'Usuario registrado: ${response['user']['email']}',
        );
      } else {
        _showErrorDialog(context, response['detail'] ?? 'Error desconocido');
      }
    } catch (e) {
      _showErrorDialog(context, 'No se pudo conectar al servidor. Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Registro exitoso'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(onPressed: _register, child: Text('Registrarse')),
      ],
    );
  }
}
