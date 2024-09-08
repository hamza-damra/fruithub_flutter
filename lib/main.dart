import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/widgets/app_controller.dart';
import 'auth/helpers/shared_pref_manager.dart';
import 'auth/helpers/app_routes.dart';
import 'auth/screens/signin_screen.dart';
import 'bloc/cubit/auth_cubit.dart';
import 'bloc/cubit/filter_products_cubit.dart';

void main() {
  // SharedPrefManager().deleteData('token');
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
  bool _isUserLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    FlutterNativeSplash.remove();
  }

  Future<void> _checkLoginStatus() async {
    String? token = await SharedPrefManager().getData('token');
<<<<<<< HEAD
    setState(() {
      _isUserLoggedIn = (token != null) && (token.isNotEmpty);
=======

    setState(() {
      _isUserLoggedIn = (token != null && token.isNotEmpty);
>>>>>>> fix-login
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(ManageUsers()),
        ),
        BlocProvider<ProductsCubit>(
          create: (context) => ProductsCubit(),
        ),
      ],
      child: MaterialApp(
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
        home: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _isUserLoggedIn
            ? const AppController()
            : const SignInScreen(),
        onGenerateRoute: generateRoute,
=======
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
        child: _isLoading
            ? const Scaffold(
                backgroundColor: Colors.white,
                body: SizedBox(),
              )
            : _isUserLoggedIn
                ? const AppController()
                : const SignInScreen(),
>>>>>>> fix-login
      ),
    );
  }
}
