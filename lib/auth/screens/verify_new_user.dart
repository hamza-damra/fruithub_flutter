import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../bloc/state/auth_state.dart';
import '../helpers/app_routes.dart';
=======
import 'package:fruitshub/auth/helpers/SharedPrefManager.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/widgets/app_controller.dart';
import 'package:http/http.dart' as http;
>>>>>>> fix-login

class VerifyNewUser extends StatefulWidget {
  const VerifyNewUser({
    super.key,
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  State<VerifyNewUser> createState() => _VerifyNewUserState();
}

class _VerifyNewUserState extends State<VerifyNewUser> {
  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();
  final TextEditingController c4 = TextEditingController();
  final ManageUsers user = ManageUsers();

  @override
  void initState() {
    verifyUser();
    super.initState();
  }

  Future<void> verifyUser() async {
    await user.verifyUser(widget.email);
  }

  Future<void> confirmUser() async {
    String code = c1.text + c2.text + c3.text + c4.text;
    if (code.length == 4) {
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

      // confirm request
      http.Response otpResponse = await user.confirmUser(code);

      // request success
      if (otpResponse.statusCode == 200 || otpResponse.statusCode == 201) {
        // sign in and save user token
        http.Response signinResponse = await user.signinUser(
          widget.email,
          widget.password,
        );
        Map<String, dynamic> response = jsonDecode(signinResponse.body);
        SharedPrefManager().saveData('token', response['token']);

        // ahow success dialog
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('حساب جديد', textAlign: TextAlign.right),
              content: const Text(
                  'تم تسجيل حسابك بنجاح ، يمكنك الان تصفح منتجاتنا',
                  textAlign: TextAlign.right),
              actions: <Widget>[
                TextButton(
                  child: const Text('تصفح المنتجات'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppController(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      }

      // wrong otp
      else if (otpResponse.statusCode == 400) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('كود تفعيل خاطئ', textAlign: TextAlign.right),
              content: const Text('يرجي التاكد من الكود المرسل واعاده المحاوله',
                  textAlign: TextAlign.right),
              actions: <Widget>[
                TextButton(
                  child: const Text('اعاده المحاوله'),
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

    // user didn't enter otp
    else if (code.length < 4) {
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
    }
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
        title: const Text('التحقق من الرمز'),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'لقد ارسلنا كود تفعيل حسابك',
                  textAlign: TextAlign.right,
                  softWrap: true,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'يرجي التحقق من الايميل وكتابه الكود المرسل',
                  textAlign: TextAlign.right,
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
<<<<<<< HEAD
                  buildOtpTextField(widget.c1),
                  buildOtpTextField(widget.c2),
                  buildOtpTextField(widget.c3),
                  buildOtpTextField(widget.c4),
=======
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
>>>>>>> fix-login
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: screenWidth * 0.90,
            child: ElevatedButton(
<<<<<<< HEAD
              onPressed: () {
                String code = widget.c1.text + widget.c2.text + widget.c3.text + widget.c4.text;
                if (code.length == 4) {
                  context.read<AuthCubit>().confirmUser(code);
                } else {
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
                }
=======
              onPressed: () async {
                await confirmUser();
>>>>>>> fix-login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B5E37),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'تحقق من الرمز',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is UserVerificationSuccess) {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              } else if (state is AuthError) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('خطأ', textAlign: TextAlign.right),
                      content: Text(state.message, textAlign: TextAlign.right),
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
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget buildOtpTextField(TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.17,
      child: TextField(
        controller: controller,
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
    );
  }
}
