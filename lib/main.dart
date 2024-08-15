import 'package:flutter/material.dart';
import 'package:fruitshub/screens/signin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Cairo', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 14),
          displayLarge: TextStyle(fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.normal),
          titleSmall: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.normal),
          labelLarge: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      home: const SignInScreen(),
    );
  }
}
