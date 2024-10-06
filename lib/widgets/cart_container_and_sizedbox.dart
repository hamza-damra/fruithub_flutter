import 'package:flutter/material.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      width: screenWidth * 0.08,
      height: screenHeight * 0.08,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff1B5E37),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}

class CartSizedBox extends StatelessWidget {
  const CartSizedBox({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.07,
      height: screenWidth * 0.07,
      child: child,
    );
  }
}
