import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/auth/screens/signin_screen.dart';
import 'package:fruitshub/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final emailController = TextEditingController();
  final confirmEmailController = TextEditingController();
  final otpControllers = List.generate(4, (index) => TextEditingController());
  String? emailErrorText;
  String? confirmEmailErrorText;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> logOut() async {
    await SharedPrefManager().deleteData('token');
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  Future<void> _submitForm() async {
    final code = otpControllers.map((controller) => controller.text).join();
    var hasError = false;

    setState(() {
      emailErrorText = null;
      confirmEmailErrorText = null;
    });

    if (!_validateEmail()) hasError = true;
    if (code.length < 4) {
      _showErrorDialog('ادخل الكود المكون من أربع أرقام');
      hasError = true;
    }

    if (hasError) return;

    _showLoadingDialog();

    try {
      final response = await ManageUsers().verifyOtpAndResetEmail(
        otp: code,
        newEmail: emailController.text,
        confirmEmail: confirmEmailController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      _handleResponse(response);
    } catch (error) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      _showErrorDialog('حدث خطأ ما. حاول مرة أخرى.');
    }
  }

  bool _validateEmail() {
    var hasError = false;

    if (emailController.text.isEmpty) {
      setState(() => emailErrorText = 'هذا الحقل مطلوب');
      hasError = true;
    } else if (!isValidEmail(emailController.text)) {
      setState(() => emailErrorText = 'البريد الالكتروني غير صحيح');
      hasError = true;
    }

    if (confirmEmailController.text.isEmpty) {
      setState(() => confirmEmailErrorText = 'هذا الحقل مطلوب');
      hasError = true;
    } else if (!isValidEmail(confirmEmailController.text)) {
      setState(() => confirmEmailErrorText = 'البريد الالكتروني غير صحيح');
      hasError = true;
    }

    if (emailController.text != confirmEmailController.text) {
      setState(() {
        emailErrorText = confirmEmailErrorText = 'البريد الالكتروني غير متطابق';
      });
      hasError = true;
    }

    return !hasError;
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      _showSuccessDialog();
    } else if (response.statusCode == 417) {
      _showErrorDialog('كود تفعيل خاطئ');
    } else {
      _showErrorDialog('حدث خطأ غير متوقع.');
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Colors.black),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('خطأ', textAlign: TextAlign.right),
          content: Text(message, textAlign: TextAlign.right),
          actions: [
            TextButton(
              child: const Text('حاول مرة أخرى'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('نجاح', textAlign: TextAlign.right),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child: Text(
                  'تم إعادة تعيين البريد الالكتروني بنجاح',
                  style: TextStyle(
                      fontFamily: 'Cairo', fontWeight: FontWeight.w600),
                  textAlign: TextAlign.right,
                ),
              ),
              FittedBox(
                child: Text(
                  'يجب عليك اعاده تسجيل الدخول مجددا',
                  style: TextStyle(
                      fontFamily: 'Cairo', fontWeight: FontWeight.w600),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('العودة لتسجيل الدخول'),
              onPressed: () {
                logOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('تغيير الايميل',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildResponsiveText(
                'ادخل الكود المرسل الي الايميل',
                screenWidth,
              ),
              _buildOtpFields(
                screenWidth,
              ),
              const SizedBox(height: 15),
              _buildResponsiveText(
                'البريد الالكتروني الجديد',
                screenWidth,
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MyTextField(
                  controller: emailController,
                  errorText: emailErrorText,
                  hint: 'البريد الالكتروني الجديد',
                  showprefixIcon: true,
                  align: TextAlign.right,
                  readOnly: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: MyTextField(
                  align: TextAlign.right,
                  readOnly: false,
                  controller: confirmEmailController,
                  errorText: confirmEmailErrorText,
                  hint: 'تاكيد البريد الالكتروني الجديد',
                  showprefixIcon: true,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E37),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'تغيير البريد الالكتروني',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveText(String text, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(right: 0, bottom: 7),
      child: Align(
        alignment: Alignment.centerRight,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpFields(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        4,
        (index) => SizedBox(
          width: screenWidth * 0.17,
          child: TextField(
            controller: otpControllers[index],
            style: const TextStyle(
                fontFamily: 'Cairo', fontWeight: FontWeight.bold),
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
                borderSide: const BorderSide(color: Colors.amber),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}
