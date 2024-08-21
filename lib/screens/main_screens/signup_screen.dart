import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruitshub/screens/main_screens/signin_screen.dart';
import 'package:fruitshub/widgets/my_textfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: const SizedBox(),
        title: const Text(
          'حساب جديد',
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
                  hint: 'الاسم كامل',
                  showSuffixIcon: false,
                ),
                const SizedBox(height: 20),
                const MyTextField(
                  hint: 'البريد الالكتروني',
                  showSuffixIcon: false,
                ),
                const SizedBox(height: 20),
                const MyTextField(
                  hint: 'كلمة المرور',
                  showSuffixIcon: true,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      activeColor: const Color(0xFF1B5E37),
                      onChanged: (bool? value) {},
                    ),
                    const Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'من خلال إنشاء حساب، فإنك توافق على ',
                          style: TextStyle(color: Color(0XFF949D9E)),
                          children: [
                            TextSpan(
                              text: 'الشروط والأحكام الخاصة بنا',
                              style: TextStyle(color: Color(0XFF2D9F5D)),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
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
                    'إنشاء حساب جديد',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'تمتلك حساب بالفعل؟ ',
                      style: const TextStyle(
                          fontSize: 16, color: Color(0XFF949D9E)),
                      children: [
                        TextSpan(
                          text: 'تسجيل دخول',
                          style: const TextStyle(
                              fontSize: 16, color: Color(0XFF1B5E37)),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
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
