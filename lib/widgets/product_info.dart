import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  final Widget title;
  final Widget subTitle;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive sizes
    double containerHeight = screenHeight * 0.12; // 12% of screen height
    double borderRadius = screenWidth * 0.03; // 3% of screen width
    double borderWidth = screenWidth * 0.003; // 0.3% of screen width

    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: const Color.fromARGB(255, 210, 210, 212),
          width: borderWidth,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image section with responsive size
          Expanded(
            flex:
                3, // Adjust flex based on how much space you want the image to take
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
              child: SvgPicture.asset(
                image,
                fit: BoxFit.contain,
                height: containerHeight * 0.5, // Adjust the image height
              ),
            ),
          ),
          // Title and Subtitle section with responsive layout
          Expanded(
            flex:
                5, // Adjust flex based on how much space you want the text to take
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: title),
                  SizedBox(
                      height: screenHeight *
                          0.01), // Add space between title and subtitle
                  Flexible(child: subTitle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
