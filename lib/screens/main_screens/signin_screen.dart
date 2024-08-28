import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruitshub/screens/main_screens/signup_screen.dart';
import 'package:fruitshub/widgets/my_textfield.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              children: [
                const SizedBox(height: 40),
                const MyTextField(
                  align: TextAlign.right,
                  hint: 'البريد الالكتروني',
                  showSuffixIcon: false,
                ),
                const SizedBox(height: 20),
                const MyTextField(
                  align: TextAlign.right,
                  hint: 'كلمه السر',
                  showSuffixIcon: true,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
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
                  onPressed: () {},
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
                              Navigator.push(
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
