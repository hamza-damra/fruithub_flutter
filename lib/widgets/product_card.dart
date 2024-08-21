import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xffF3F5F7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: screenWidth * 0.06,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    'assets/images/strawberry.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                'فراولة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff0C0D0D),
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth * 0.08,
                height: screenHeight * 0.08,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff1B5E37),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: screenWidth * 0.05,
                  ),
                ),
              ),
              Flexible(
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
                        '30',
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
