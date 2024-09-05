import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/auth/screens/reset_password.dart';
import 'package:fruitshub/widgets/my_textfield.dart';

import '../bloc/cubit/auth_cubit.dart';
import '../bloc/state/auth_state.dart';

class SendResetPasswordEmail extends StatefulWidget {
  const SendResetPasswordEmail({super.key});

  @override
  State<SendResetPasswordEmail> createState() => _SendResetPasswordEmailState();
}

class _SendResetPasswordEmailState extends State<SendResetPasswordEmail> {
  final TextEditingController emailController = TextEditingController();
  String? emailErrorText;

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text('نسيان كلمة المرور'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لا تقلق ، ما عليك سوى كتابة بريدك الالكتروني',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xff616A6B),
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.04, // responsive font size
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'وسنرسل رمز التحقق',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xff616A6B),
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.04, // responsive font size
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MyTextField(
                hint: 'البريد الالكتروني',
                showSuffixIcon: false,
                align: TextAlign.right,
                controller: emailController,
                errorText: emailErrorText,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is PasswordResetEmailSent) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPassword(),
                      ),
                    );
                  } else if (state is AuthError) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('خطا', textAlign: TextAlign.right),
                          content: Text(
                            state.message,
                            textAlign: TextAlign.right,
                          ),
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
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          !isValidEmail(emailController.text)) {
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
                      } else {
                        setState(() {
                          emailErrorText = null;
                        });

                        context.read<AuthCubit>()
                            .sendResetPasswordEmail(emailController.text);
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
                      'نسيت كلمة المرور',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
