import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitshub/widgets/app_controller.dart';
import 'package:fruitshub/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppController(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '..! صباح الخير',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * textScaleFactor,
                  ),
                ),
                Text(
                  'أحمد مصطفي',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 16 * textScaleFactor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: CircleAvatar(
              radius: screenWidth * 0.07, // Responsive radius
              backgroundImage: const AssetImage('assets/images/avatar.jpg'),
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 220, 228, 221),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
              ),
              onPressed: () {},
              color: const Color.fromARGB(255, 39, 139, 43),
              iconSize: screenWidth * 0.07, // Responsive icon size
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.01), // Responsive spacing
          Padding(
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
                  const Spacer(flex: 25),
                  Text(
                    '.... ابحث عن',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14 * textScaleFactor,
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
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: 50,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2.5,
                      mainAxisSpacing: 8,
                      crossAxisSpacing:
                          MediaQuery.of(context).size.width * 0.04,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
