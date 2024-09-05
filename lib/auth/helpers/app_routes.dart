import 'package:flutter/material.dart';
import 'package:fruitshub/auth/screens/signin_screen.dart';
import 'package:fruitshub/auth/screens/signup_screen.dart';
import 'package:fruitshub/auth/screens/reset_password.dart';
import 'package:fruitshub/widgets/app_controller.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String resetPassword = '/reset_password';
}


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.initial:
      return MaterialPageRoute(builder: (_) => const SignInScreen());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const AppController());
    case AppRoutes.signIn:
      return MaterialPageRoute(builder: (_) => const SignInScreen());
    case AppRoutes.signUp:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());
    case AppRoutes.resetPassword:
      return MaterialPageRoute(builder: (_) => const ResetPassword());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
