import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitshub/search/search_delegate.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.textScaleFactor,
    required this.onTap,
  });

  final double screenWidth;
  final double screenHeight;
  final double textScaleFactor;
  final void Function()? onTap;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(flex: 1),
            GestureDetector(
              onTap: onTap,
              child: Image.asset(
                'assets/images/setting-lines.png',
                color: Colors.grey[700],
                width: screenWidth * 0.05,
              ),
            ),
            const Spacer(flex: 25),
            GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: Searchdelegate(),
                );
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '.... ابحث عن',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14 * textScaleFactor,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: Searchdelegate(),
                );
              },
              child: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: const Color(0xff1B5E37),
                size: screenWidth * 0.05,
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
