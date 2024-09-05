import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fruitshub/auth/helpers/SharedPrefManager.dart';
import 'package:fruitshub/cubit/filter_products_cubit.dart';
import 'package:fruitshub/auth/screens/signin_screen.dart';
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
  late Future<Widget> _initialScreen;

  @override
  void initState() {
    super.initState();
    _initialScreen = _getInitialScreen();
    FlutterNativeSplash.remove();
  }

  Future<Widget> _getInitialScreen() async {
    String token = await SharedPrefManager().getData('token');
    if (token.isEmpty) {
      return const SignInScreen();
    } else {
      return const AppController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _initialScreen,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to resolve, show a loading indicator
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle any errors
          return const Center(child: Text('An error occurred'));
        } else {
          // Once the future completes, show the appropriate screen
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Cairo',
              textTheme: const TextTheme(
                bodyLarge: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                bodyMedium: TextStyle(fontFamily: 'Cairo', fontSize: 14),
                displayLarge: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                displayMedium: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                displaySmall: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                headlineMedium: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                headlineSmall: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                titleLarge: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                titleMedium: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                titleSmall: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                labelLarge: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            home: BlocProvider(
              create: (context) => ProductsCubit(),
              child: snapshot.data!,
            ),
          );
        }
      },
    );
  }
}
