import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/auth/screens/verify_new_user.dart';
import 'package:fruitshub/auth/screens/signin_screen.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? nameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();
  final TextEditingController c4 = TextEditingController();
  final ManageUsers user = ManageUsers();

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

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

  Future<void> signUP() async {
    try {
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

      // signUp request
      http.Response signUpResponse = await user.signUP(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      if(mounted) {
        Navigator.pop(context);
      }
      // request success
      if (signUpResponse.statusCode == 200 ||
          signUpResponse.statusCode == 201) {
        // verify user
        if(mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerifyNewUser(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
            ),
          );
        }
      }

      // email error
      else if (signUpResponse.statusCode == 400) {
        if(mounted) {
          showCustomDialog(
            context,
            'خطا',
            'هذا الايميل مستخدم بالفعل',
            'حاول مره اخري',
          );
        }
      }
    }

    // unexpected error
    on Exception {
      if(mounted) {
        Navigator.of(context).pop();
        showCustomDialog(
          context,
          'خطأ في الشبكة',
          'حدث خطأ في الشبكة. يرجى المحاولة مرة أخرى.',
          'حاول مره اخري',
        );
      }
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
                Image.asset(
                  'assets/app/splashIcon.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 40),
                MyTextField(
                  align: TextAlign.right,
                  hint: 'الاسم كامل',
                  showprefixIcon: false,
                  controller: nameController,
                  errorText: nameErrorText,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  align: TextAlign.right,
                  hint: 'البريد الالكتروني',
                  showprefixIcon: false,
                  controller: emailController,
                  errorText: emailErrorText,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  align: TextAlign.right,
                  hint: 'كلمة المرور',
                  showprefixIcon: true,
                  controller: passwordController,
                  errorText: passwordErrorText,
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
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        nameController.text.length < 3 ||
                        !isValidEmail(emailController.text) ||
                        passwordController.text.length < 8) {
                      if (nameController.text.isEmpty) {
                        setState(() {
                          nameErrorText = 'هذا الحقل مطلوب';
                        });
                      } else if (nameController.text.length < 3) {
                        setState(() {
                          nameErrorText =
                              'يجب ان يتكون الاسم علي الاقل من ثلاث حروف';
                        });
                      } else {
                        setState(() {
                          nameErrorText = null;
                        });
                      }

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
                      } else if (passwordController.text.length < 8) {
                        setState(() {
                          passwordErrorText =
                              'كلمه السر يجب ان تكون علي الاقل 8 حروف';
                        });
                      } else {
                        setState(() {
                          passwordErrorText = null;
                        });
                      }
                    } else {
                      setState(() {
                        nameErrorText = null;
                        emailErrorText = null;
                        passwordErrorText = null;
                      });
                      await signUP();
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
                              Navigator.pushReplacement(
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
