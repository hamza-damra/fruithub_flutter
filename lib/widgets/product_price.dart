import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            Text(
              'الكيلو',
              style: TextStyle(
                color: const Color(0xffF8C76D),
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
                fontSize: screenWidth * 0.040,
              ),
            ),
            Text(
              '/',
              style: TextStyle(
                color: const Color(0xffF8C76D),
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
                fontSize: screenWidth * 0.040,
              ),
            ),
            Text(
              'جنية',
              style: TextStyle(
                color: const Color(0xffF4A91F),
                fontWeight: FontWeight.w700,
                fontFamily: 'Cairo',
                fontSize: screenWidth * 0.040,
              ),
            ),
            Text(
              price.toString(),
              style: TextStyle(
                color: const Color(0xffF4A91F),
                fontWeight: FontWeight.w700,
                fontFamily: 'Cairo',
                fontSize: screenWidth * 0.040,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
