import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DeleteUserForm extends StatefulWidget {
  @override
  _DeleteUserFormState createState() => _DeleteUserFormState();
}

class _DeleteUserFormState extends State<DeleteUserForm> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _deleteUser() async {
    final String email = _emailController.text;

    if (email.isEmpty) {
      _showErrorDialog(context, 'Por favor ingrese un email');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.deleteUser(email);

      if (response['statusCode'] == 200) {
        _showSuccessDialog(context, response['message']);
        _emailController.clear();
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
            title: Text('Usuario eliminado'),
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
          decoration: InputDecoration(labelText: 'Email a eliminar'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20),
        _isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
              onPressed: _deleteUser,
              child: Text('Eliminar Usuario'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color rojo para indicar peligro
              ),
            ),
      ],
    );
  }
}
