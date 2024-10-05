import 'package:auto_size_text/auto_size_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:fruitshub/models/product.dart';

class LastAddedProductCard extends StatelessWidget {
  const LastAddedProductCard({
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
    return Padding(
      padding:
          EdgeInsets.only(left: screenWidth * 0.02), // Responsive left padding
      child: SizedBox(
        width: screenWidth * 0.20, // Adjusted size for better fit
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Container(
                width: screenWidth * 0.20, // 20% of screen width
                height: screenWidth * 0.20, // Ensure square shape
                decoration: const BoxDecoration(
                  color: Color(0xffF3F5F7),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth *
                      0.02), // Responsive padding inside the circle
                  child: FancyShimmerImage(
                    errorWidget: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(35)),
                      child: Image.asset(
                        'assets/images/image-error-placeHolder.png',
                      ),
                    ),
                    imageUrl: product.imageUrl,
                    shimmerBaseColor: Colors.grey[300],
                    shimmerHighlightColor: Colors.white,
                    boxFit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight *
                  0.01, // Responsive space between image and text
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: AutoSizeText(
                  product.name,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
