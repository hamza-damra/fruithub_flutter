import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.hint,
    required this.showSuffixIcon,
  });

  final String hint;
  final bool showSuffixIcon;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.showSuffixIcon ? _isHidden : false,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
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
        prefixIcon: widget.showSuffixIcon
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
