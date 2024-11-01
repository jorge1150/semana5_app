import 'package:flutter/material.dart';
import 'pages/welcome_screen.dart';

void main() {
  runApp(ComputerApp());
}

class ComputerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Computadoras App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.orange,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.blue.shade50,
          border: OutlineInputBorder(),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
