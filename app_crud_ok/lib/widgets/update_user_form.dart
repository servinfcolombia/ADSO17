import 'package:flutter/material.dart';
import '../services/api_service.dart';

class UpdateUserForm extends StatefulWidget {
  @override
  _UpdateUserFormState createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final TextEditingController _currentEmailController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _updateUser() async {
    final String currentEmail = _currentEmailController.text;
    final String newEmail = _newEmailController.text;
    final String newPassword = _newPasswordController.text;

    if (currentEmail.isEmpty || newEmail.isEmpty || newPassword.isEmpty) {
      _showErrorDialog(context, 'Por favor complete todos los campos');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.updateUser(
        currentEmail,
        newEmail,
        newPassword,
      );

      if (response['statusCode'] == 200) {
        _showSuccessDialog(context, response['message']);
        _clearFields();
      } else {
        _showErrorDialog(context, response['detail'] ?? 'Error desconocido');
      }
    } catch (e) {
      _showErrorDialog(context, 'Error al actualizar: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearFields() {
    _currentEmailController.clear();
    _newEmailController.clear();
    _newPasswordController.clear();
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Actualización exitosa'),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _currentEmailController,
            decoration: InputDecoration(
              labelText: 'Email actual',
              hintText: 'Ingrese su email actual',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          TextField(
            controller: _newEmailController,
            decoration: InputDecoration(
              labelText: 'Nuevo email',
              hintText: 'Ingrese su nuevo email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          TextField(
            controller: _newPasswordController,
            decoration: InputDecoration(
              labelText: 'Nueva contraseña',
              hintText: 'Ingrese su nueva contraseña',
            ),
            obscureText: true,
          ),
          SizedBox(height: 24),
          _isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                onPressed: _updateUser,
                child: Text('Actualizar Usuario'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
        ],
      ),
    );
  }
}
