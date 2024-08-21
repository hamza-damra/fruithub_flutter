import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.textScaleFactor,
  });

  final double screenWidth;
  final double screenHeight;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.05, // Responsive height
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            ///////
            // search logic
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(flex: 25),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '.... ابحث عن',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14 * textScaleFactor,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.02,
              ),
              FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: const Color(0xff1B5E37),
                size: screenWidth * 0.05,
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
