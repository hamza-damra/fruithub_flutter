import 'package:flutter/material.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.product,
  });

  final double screenWidth;
  final double screenHeight;
  final Product product;

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
                  child: FancyShimmerImage(
                    imageUrl: product.imageUrl,
                    shimmerBaseColor: Colors.grey[300],
                    shimmerHighlightColor: Colors.white,
                    boxFit: BoxFit.contain,
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
                product.name,
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
                        product.price.toString(),
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
