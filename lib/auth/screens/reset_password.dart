import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/widgets/my_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    super.key,
    this.screen,
    this.email,
  });

  final String? screen;
  final String? email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController c1 = TextEditingController();
  final TextEditingController c2 = TextEditingController();
  final TextEditingController c3 = TextEditingController();
  final TextEditingController c4 = TextEditingController();
  String? passwordErrorText;
  String? confirmPasswordErrorText;
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
            _buildHeaderText(screenWidth, 'ادخل الكود المرسل الي الايميل'),
            _buildOtpFields(screenWidth),
            const SizedBox(height: 10),
            _buildHeaderText(screenWidth, 'اختر كلمه المرور الجديده'),
            _buildPasswordFields(),
            const SizedBox(height: 10),
            _buildResetPasswordButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText(double screenWidth, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return SizedBox(
            width: screenWidth * 0.17,
            child: TextField(
              controller: _getController(index),
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) => _handleOtpChange(value, index),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: _inputDecoration(),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPasswordFields() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyTextField(
            readOnly: false,
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
            readOnly: false,
            hint: 'تأكيد كلمة المرور',
            showprefixIcon: true,
            align: TextAlign.right,
            controller: confirmPasswordController,
            errorText: confirmPasswordErrorText,
          ),
        ),
      ],
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.90,
      child: ElevatedButton(
        onPressed: () => _handleResetPassword(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B5E37),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'إعادة تعيين كلمة المرور',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
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
    );
  }

  TextEditingController _getController(int index) {
    switch (index) {
      case 0:
        return c1;
      case 1:
        return c2;
      case 2:
        return c3;
      case 3:
        return c4;
      default:
        return c1;
    }
  }

  void _handleOtpChange(String value, int index) {
    if (value.length == 1) {
      FocusScope.of(context).nextFocus();
    } else if (index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  Future<void> _handleResetPassword(BuildContext context) async {
    code = c1.text + c2.text + c3.text + c4.text;
    if (_validateInputs()) return;

    // Show loading
    _showLoadingDialog(context);

    try {
      final response = await user.verifyResetPasswordByOtp(
        code,
        passwordController.text,
        confirmPasswordController.text,
      );

      Navigator.pop(context); // Close loading

      if (_isSuccess(response.statusCode)) {
        _showSuccessDialog(context);
      } else if (_isInvalidOtp(response.statusCode)) {
        _showInvalidOtpDialog(context);
      } else {
        _showErrorDialog(context,
            'حدث خطأ أثناء إعادة تعيين كلمة المرور. حاول مرة أخرى لاحقًا.');
      }
    } catch (e) {
      Navigator.pop(context); // Close loading
      _showErrorDialog(
        context,
        'حدث خطأ غير متوقع. يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.',
      );
    }
  }

  bool _validateInputs() {
    bool hasError = false;

    setState(() {
      passwordErrorText = _validatePassword(passwordController.text);
      confirmPasswordErrorText =
          _validatePassword(confirmPasswordController.text);
    });

    if (passwordErrorText != null || confirmPasswordErrorText != null) {
      hasError = true;
    } else if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        passwordErrorText = confirmPasswordErrorText = 'كلمة السر غير متطابقة';
      });
      hasError = true;
    }

    if (code.length < 4) {
      _showDialog('خطأ', 'ادخل الكود المكون من أربع أرقام');
      hasError = true;
    }

    return hasError;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'هذا الحقل مطلوب';
    } else if (password.length < 8) {
      return 'كلمة السر يجب أن تكون على الأقل 8 حروف';
    }
    return null;
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    _showDialog(
      'نجاح',
      'تم إعادة تعيين كلمة المرور بنجاح',
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child:
              Text(widget.screen == 'reset' ? 'عوده' : 'العودة لتسجيل الدخول'),
        ),
      ],
    );
  }

  void _showInvalidOtpDialog(BuildContext context) {
    _showDialog(
      'كود تفعيل خاطئ',
      'يرجي التأكد من الكود المرسل وإعادة المحاولة',
      actions: [
        TextButton(
          child: const Text('إعادة المحاولة'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    _showDialog(
      'خطأ',
      message,
      actions: [
        TextButton(
          child: const Text('حسنًا'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showDialog(String title, String content, {List<Widget>? actions}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.right),
          content: Text(content, textAlign: TextAlign.right),
          actions: actions ??
              [
                TextButton(
                  child: const Text('حاول مرة أخرى'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
        );
      },
    );
  }

  bool _isSuccess(int statusCode) => statusCode == 200;

  bool _isInvalidOtp(int statusCode) => statusCode == 417;
}
