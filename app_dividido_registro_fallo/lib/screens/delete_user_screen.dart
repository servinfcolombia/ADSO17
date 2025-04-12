import 'package:flutter/material.dart';
import '../widgets/delete_user_form.dart';

class DeleteUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar Usuario'),
        backgroundColor: Colors.red, // Color rojo para indicar peligro
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DeleteUserForm(),
      ),
    );
  }
}
