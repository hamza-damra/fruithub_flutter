import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/auth/screens/verify_new_user.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../bloc/state/auth_state.dart';
import '../../utils/error_handler.dart'; // Import the centralized error handler

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

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'تسجيل الدخول',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          ErrorHandler.handleAuthError(context, state);
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyNewUser(
                  title: 'أدخل الرمز المرسل إلى بريدك الإلكتروني',
                  subTitle: 'من فضلك أدخل الرمز المكون من 4 أرقام للتحقق من حسابك',
                  onPressed: () {},
                  c1: TextEditingController(),
                  c2: TextEditingController(),
                  c3: TextEditingController(),
                  c4: TextEditingController(),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyTextField(
                      align: TextAlign.right,
                      hint: 'الاسم كامل',
                      showSuffixIcon: false,
                      controller: nameController,
                      errorText: nameErrorText,
                    ),
                    const SizedBox(height: 20),
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
                      hint: 'كلمة المرور',
                      showSuffixIcon: true,
                      controller: passwordController,
                      errorText: passwordErrorText,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          setState(() {
                            nameErrorText = nameController.text.isEmpty
                                ? 'هذا الحقل مطلوب'
                                : null;
                            emailErrorText = emailController.text.isEmpty
                                ? 'هذا الحقل مطلوب'
                                : null;
                            passwordErrorText = passwordController.text.isEmpty
                                ? 'هذا الحقل مطلوب'
                                : null;
                          });
                        } else {
                          setState(() {
                            nameErrorText = null;
                            emailErrorText = null;
                            passwordErrorText = null;
                          });

                          context.read<AuthCubit>().signUp(
                            nameController.text,
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
                        'إنشاء حساب جديد',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
