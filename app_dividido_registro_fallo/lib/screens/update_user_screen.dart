import 'package:flutter/material.dart';
import '../widgets/update_user_form.dart';

class UpdateUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Actualizar Usuario')),
      body: SingleChildScrollView(child: UpdateUserForm()),
    );
  }
}
