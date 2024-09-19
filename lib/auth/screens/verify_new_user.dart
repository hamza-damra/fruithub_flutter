import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/widgets/app_controller.dart';
import 'package:http/http.dart' as http;

import '../helpers/shared_pref_manager.dart';

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
        http.Response signinResponse = await user.signInUser(
          widget.email,
          widget.password,
        );
        Map<String, dynamic> response = jsonDecode(signinResponse.body);
        SharedPrefManager().saveData('token', response['token']);

        if(mounted){
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

      }

      // wrong otp
      else if (otpResponse.statusCode == 400) {
        if(mounted){
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
          const SizedBox(height: 20),
          SizedBox(
            width: screenWidth * 0.90,
            child: ElevatedButton(
              onPressed: () async {
                await confirmUser();
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
        ],
      ),
    );
  }
}