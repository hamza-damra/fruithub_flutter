import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit/auth_cubit.dart';
import '../../bloc/state/auth_state.dart';
import '../helpers/app_routes.dart';

class VerifyNewUser extends StatefulWidget {
  const VerifyNewUser({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onPressed,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
  });

  final String title;
  final String subTitle;
  final void Function()? onPressed;
  final TextEditingController c1;
  final TextEditingController c2;
  final TextEditingController c3;
  final TextEditingController c4;

  @override
  State<VerifyNewUser> createState() => _VerifyNewUserState();
}

class _VerifyNewUserState extends State<VerifyNewUser> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.right,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.subTitle,
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
                  buildOtpTextField(widget.c1),
                  buildOtpTextField(widget.c2),
                  buildOtpTextField(widget.c3),
                  buildOtpTextField(widget.c4),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: screenWidth * 0.90,
            child: ElevatedButton(
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
