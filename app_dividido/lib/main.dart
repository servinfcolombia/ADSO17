import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart'; // Añade esta importación

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
        '/register': (context) => RegisterScreen(), // Añade esta ruta
      },
    );
  }
}
