import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/delete_user_screen.dart';
import 'screens/user_list_screen.dart';
import 'screens/update_user_screen.dart'; // Añade esta importación

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login con FastAPI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      routes: {
        '/register': (context) => RegisterScreen(),
        '/delete_user': (context) => DeleteUserScreen(),
        '/user_list': (context) => UserListScreen(),
        '/update_user': (context) => UpdateUserScreen(), // Añade esta ruta
      },
    );
  }
}
