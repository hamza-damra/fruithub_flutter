import 'package:flutter/material.dart';

class AddressController extends StatelessWidget {
  const AddressController({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final onTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
          ),
        ),
      ),
    );
  }
}
