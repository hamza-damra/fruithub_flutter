import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passwordController = TextEditingController();
  String? passwordErrorText;
  TextEditingController confirmPasswordController = TextEditingController();
  String? confirmPasswordErrorText;

  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  late String code;
  final user = ManageUsers();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text('كلمة مرور جديدة'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // responsive text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'ادخل الكود المرسل الي الايميل',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.17,
                      child: TextField(
                        controller: c1,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          fillColor: const Color(0xffF9FAFA),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.17,
                      child: TextField(
                        controller: c2,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          fillColor: const Color(0xffF9FAFA),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.17,
                      child: TextField(
                        controller: c3,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          fillColor: const Color(0xffF9FAFA),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.17,
                      child: TextField(
                        controller: c4,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                          } else {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          fillColor: const Color(0xffF9FAFA),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'اختر كلمه المرور الجديده',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                hint: 'كلمة مرور جديدة',
                showprefixIcon: true,
                align: TextAlign.right,
                controller: passwordController,
                errorText: passwordErrorText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                hint: 'تأكيد كلمة المرور',
                showprefixIcon: true,
                align: TextAlign.right,
                controller: confirmPasswordController,
                errorText: confirmPasswordErrorText,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: ElevatedButton(
                onPressed: () async {
                  code = c1.text + c2.text + c3.text + c4.text;

                  bool hasError = false;

                  // Reset error texts
                  setState(() {
                    passwordErrorText = null;
                    confirmPasswordErrorText = null;
                  });

                  // Validate Password
                  if (passwordController.text.isEmpty) {
                    setState(() {
                      passwordErrorText = 'هذا الحقل مطلوب';
                    });
                    hasError = true;
                  } else if (passwordController.text.length < 8) {
                    setState(() {
                      passwordErrorText =
                          'كلمة السر يجب أن تكون على الأقل 8 حروف';
                    });
                    hasError = true;
                  }

                  // Validate Confirm Password
                  if (confirmPasswordController.text.isEmpty) {
                    setState(() {
                      confirmPasswordErrorText = 'هذا الحقل مطلوب';
                    });
                    hasError = true;
                  } else if (confirmPasswordController.text.length < 8) {
                    setState(() {
                      confirmPasswordErrorText =
                          'كلمة السر يجب أن تكون على الأقل 8 حروف';
                    });
                    hasError = true;
                  }

                  // Check if passwords match
                  if (passwordController.text.length >= 8 &&
                      confirmPasswordController.text.length >= 8 &&
                      passwordController.text !=
                          confirmPasswordController.text) {
                    setState(() {
                      passwordErrorText =
                          confirmPasswordErrorText = 'كلمة السر غير متطابقة';
                    });
                    hasError = true;
                  }

                  // Validate OTP Code
                  if (code.length < 4) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'خطأ',
                            textAlign: TextAlign.right,
                          ),
                          content: const Text(
                            'ادخل الكود المكون من أربع أرقام',
                            textAlign: TextAlign.right,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('حاول مرة أخرى'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    hasError = true;
                  }

                  if (hasError) {
                    return; // Stop further execution if there are errors
                  }

                  // Proceed with resetting password
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
                    http.Response verificationResponse =
                        await user.verifyResetPasswordByOtp(
                      code,
                      passwordController.text,
                      confirmPasswordController.text,
                    );
                    Navigator.pop(context);
                    print(verificationResponse.body);

                    if (verificationResponse.statusCode == 200 ||
                        verificationResponse.statusCode == 201) {
                      // success
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'نجاح',
                              textAlign: TextAlign.right,
                            ),
                            content: const Text(
                              'تم إعادة تعيين كلمة المرور بنجاح',
                              textAlign: TextAlign.right,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('العودة لتسجيل الدخول'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else if (verificationResponse.statusCode == 417) {
                      // Invalid OTP Code
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'كود تفعيل خاطئ',
                              textAlign: TextAlign.right,
                            ),
                            content: const Text(
                              'يرجي التأكد من الكود المرسل وإعادة المحاولة',
                              textAlign: TextAlign.right,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('إعادة المحاولة'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Handle other status codes
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'خطأ',
                              textAlign: TextAlign.right,
                            ),
                            content: const Text(
                              'حدث خطأ أثناء إعادة تعيين كلمة المرور. حاول مرة أخرى لاحقًا.',
                              textAlign: TextAlign.right,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('حسنًا'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } catch (e) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'خطأ',
                            textAlign: TextAlign.right,
                          ),
                          content: const Text(
                            'حدث خطأ غير متوقع. يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.',
                            textAlign: TextAlign.right,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('حسنًا'),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E37),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'إنشاء كلمة مرور جديدة',
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
