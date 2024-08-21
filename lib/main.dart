import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fruitshub/screens/main_screens/home_screen.dart';
import 'package:fruitshub/widgets/app_controller.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Cairo', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 14),
          displayLarge: TextStyle(
              fontFamily: 'Cairo', fontSize: 24, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              fontFamily: 'Cairo', fontSize: 22, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(
              fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(
              fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(
              fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.normal),
          titleSmall: TextStyle(
              fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.normal),
          labelLarge: TextStyle(
              fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      home: const Scaffold(
        body: AppController(),
      ),
    );
  }
}
