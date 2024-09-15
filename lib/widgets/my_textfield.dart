import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.hint,
    required this.showprefixIcon,
    this.inputType,
    this.controller,
    required this.align,
    this.errorText,
    this.suffixIcon,
  });

  final String hint;
  final bool showprefixIcon;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final TextAlign align;
  final String? errorText;
  final Widget? suffixIcon;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.showprefixIcon ? _isHidden : false,
      textAlign: widget.align,
      keyboardType: widget.inputType ?? TextInputType.text,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        errorText: widget.errorText,
        errorStyle: const TextStyle(
          fontFamily: 'Cairo',
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        filled: true,
        fillColor: const Color(0xffF9FAFA),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 143, 150, 146),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffE6E9EA),
          ),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        hintTextDirection: TextDirection.rtl,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.showprefixIcon
            ? IconButton(
                icon: Icon(
                  _isHidden ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isHidden = !_isHidden;
                  });
                },
              )
            : const SizedBox(),
      ),
    );
  }
}
