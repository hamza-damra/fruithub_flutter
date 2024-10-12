import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fruitshub/auth/screens/signin_screen.dart';
import 'package:fruitshub/bloc/remove_from_favourite_cubit.dart';
import 'package:fruitshub/widgets/app_controller.dart';
import 'auth/helpers/shared_pref_manager.dart';
import 'bloc/filter_products_cubit.dart';

void main() async {
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
  }

  Future<void> _checkLoginStatus() async {
    String? token = await SharedPrefManager().getData('token');

    setState(() {
      _isUserLoggedIn = (token != null && token.isNotEmpty);
      _isLoading = false;
    });

    // Remove the splash screen after the login check
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductsCubit(),
        ),
        BlocProvider(
          create: (_) => FavouriteCubit(),
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
            ? const Scaffold(
                backgroundColor: Colors.white,
                body: SizedBox(),
              )
            : StreamBuilder<ConnectivityResult>(
                // Use 'map' to extract the first or last element from the list
                stream: Connectivity().onConnectivityChanged.map((list) =>
                    list.isNotEmpty ? list.last : ConnectivityResult.none),
                builder: (context, snapshot) {
                  if (snapshot.data == ConnectivityResult.none) {
                    return Scaffold(
                      backgroundColor: const Color(0xfffafafc),
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/app/nointernet.PNG',
                              width: screenHeight * 0.5,
                              height: screenHeight * 0.25,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Text(
                              '! لا يوجد اتصال بالانترنت',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (_isUserLoggedIn) {
                    return const AppController();
                  } else {
                    return const SignInScreen();
                  }
                },
              ),
      ),
    );
  }
}
