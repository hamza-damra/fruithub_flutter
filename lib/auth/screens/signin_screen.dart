import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/auth/screens/send_reset_password_email.dart';
<<<<<<< HEAD
import 'package:fruitshub/auth/screens/signup_screen.dart'; // Add SignUp screen import
=======
import 'package:fruitshub/auth/screens/verify_new_user.dart';
import 'package:fruitshub/widgets/app_controller.dart';
>>>>>>> fix-login
import 'package:fruitshub/widgets/my_textfield.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../bloc/state/auth_state.dart';
import '../../utils/error_handler.dart'; // Import the centralized error handler

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

<<<<<<< HEAD
=======
  void showCustomDialog(
    BuildContext context,
    String title,
    String content,
    String buttonChild,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.right,
          ),
          content: Text(
            content,
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(buttonChild),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> logIn() async {
    // show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );

    try {
      // sign in request
      http.Response signInResponse = await ManageUsers().signinUser(
        emailController.text,
        passwordController.text,
      );
      Navigator.pop(context);

      // request success
      if (signInResponse.statusCode == 200 ||
          signInResponse.statusCode == 201) {
        final Map<String, dynamic> responseData =
            jsonDecode(signInResponse.body);
        SharedPrefManager().saveData('token', responseData['token']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AppController(),
          ),
        );
      }

      // user not verified
      else if (signInResponse.statusCode == 400) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyNewUser(
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
        );
      }

      // wrong data error
      else if (signInResponse.statusCode == 500) {
        showCustomDialog(
          context,
          'خطأ',
          'هذا المستخدم غير موجود او تم حذفه',
          'حسنا',
        );
      }
    }

    // unexpected error
    on Exception catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      Future.delayed(const Duration(milliseconds: 100), () {
        showCustomDialog(
          context,
          'خطأ',
          'حدث خطأ غير متوقع الرجاء المحاولة مرة أخرى لاحقًا',
          'حسنا',
        );
      });
    }
  }

>>>>>>> fix-login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: const SizedBox(),
        title: const Text(
          'تسجيل الدخول',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/app/splashIcon.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 40),
                MyTextField(
                  align: TextAlign.right,
                  hint: 'البريد الالكتروني',
                  showSuffixIcon: false,
                  controller: emailController,
                  errorText: emailErrorText,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  align: TextAlign.right,
                  hint: 'كلمه السر',
                  showSuffixIcon: true,
                  controller: passwordController,
                  errorText: passwordErrorText,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SendResetPasswordEmail();
                        },
                      ));
                    },
                    child: const Text(
                      'نسيت كلمة المرور',
                      style: TextStyle(
                        color: Color(0xFF2D9F5D),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    ErrorHandler.handleAuthError(context, state);
                    if (state is AuthSuccess) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (emailController.text.isEmpty ||
                            !isValidEmail(emailController.text) ||
                            passwordController.text.isEmpty) {
                          if (emailController.text.isEmpty) {
                            setState(() {
                              emailErrorText = 'هذا الحقل مطلوب';
                            });
                          } else if (!isValidEmail(emailController.text)) {
                            setState(() {
                              emailErrorText = 'البريد الالكتروني غير صحيح';
                            });
                          } else {
                            setState(() {
                              emailErrorText = null;
                            });
                          }

                          if (passwordController.text.isEmpty) {
                            setState(() {
                              passwordErrorText = 'هذا الحقل مطلوب';
                            });
                          } else {
                            setState(() {
                              passwordErrorText = null;
                            });
                          }
                        } else {
                          setState(() {
                            emailErrorText = null;
                            passwordErrorText = null;
                          });

                          context.read<AuthCubit>().signIn(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B5E37),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'تسجيل دخول',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'لا يوجد لديك حساب؟ ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF949D9E),
                      ),
                      children: [
                        TextSpan(
                          text: 'قم بالتسجيل الآن',
                          style: const TextStyle(
                            color: Color(0xFF1B5E37),
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
