import 'package:flutter/material.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/auth/screens/reset_password.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class SendResetPasswordEmail extends StatefulWidget {
  const SendResetPasswordEmail({super.key});

  @override
  State<SendResetPasswordEmail> createState() => _SendResetPasswordEmailState();
}

class _SendResetPasswordEmailState extends State<SendResetPasswordEmail> {
  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();
  final TextEditingController c4 = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? emailErrorText;
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  final ManageUsers user = ManageUsers();

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
                readOnly: false,
                hint: 'البريد الالكتروني',
                showprefixIcon: false,
                align: TextAlign.right,
                controller: emailController,
                errorText: emailErrorText,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: ElevatedButton(
                onPressed: () async {
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
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    );

                    http.Response verificationResponse =
                        await user.sendResetPasswordEmail(
                      emailController.text,
                    );

                    Navigator.pop(context);

                    if (verificationResponse.statusCode == 200 ||
                        verificationResponse.statusCode == 201) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPassword(),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Text('خطا', textAlign: TextAlign.right),
                            content: const Text(
                                'البريد الذي ادخلته غير موجود او تم حذفه',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
