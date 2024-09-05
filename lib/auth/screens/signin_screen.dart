import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruitshub/auth/helpers/SharedPrefManager.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/auth/screens/signup_screen.dart';
import 'package:fruitshub/auth/screens/send_reset_password_email.dart';
import 'package:fruitshub/widgets/app_controller.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  String? emailErrorText;
  TextEditingController passwordController = TextEditingController();
  String? passwordErrorText;

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> logIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );

    http.Response signInResponse = await ManageUsers()
        .signinUser(emailController.text, passwordController.text);
    Navigator.pop(context);
    if (signInResponse.statusCode == 200 || signInResponse.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AppController(),
        ),
      );
      final sharedPrefs = SharedPrefManager();
      final Map<String, dynamic> responseData = jsonDecode(signInResponse.body);
      String tocken = responseData['token'];
      await sharedPrefs.saveData('token', tocken);
      print(tocken);
    } else if (signInResponse.statusCode == 400 ||
        signInResponse.statusCode == 401) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('خطا', textAlign: TextAlign.right),
            content: const Text(
                'هذا المستخدم غير موجود او البيانات المدخله غير صحيحه',
                textAlign: TextAlign.right),
            actions: <Widget>[
              TextButton(
                child: const Text('حاول مره اخري'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

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
                ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        !isValidEmail(emailController.text) ||
                        passwordController.text.isEmpty) {
                      ////
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
                      ////

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

                      await logIn();
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
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'لا تمتلك حساب؟ ',
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFF949D9E)),
                      children: [
                        TextSpan(
                          text: 'قم بإنشاء حساب',
                          style: const TextStyle(
                              color: Color(0xFF1B5E37), fontSize: 16),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
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
