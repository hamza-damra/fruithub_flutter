import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/screens/main_screens/cart_screen.dart';
import 'package:fruitshub/screens/main_screens/home_screen.dart';
import 'package:fruitshub/screens/main_screens/products_screen.dart';
import 'package:fruitshub/screens/main_screens/profile_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppController extends StatefulWidget {
  const AppController({super.key});

  @override
  State<AppController> createState() => _AppControllerState();
}

class _AppControllerState extends State<AppController> {
  int myIndex = 3;
  final List<Widget> screens = [
    const ProfileScreen(),
    CartScreen(
      products: cartProducts,
    ),
    const ProductsScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate sizes based on screen dimensions
    double iconSize = screenWidth * 0.07;
    double fontSize = screenWidth * 0.035;
    double tabPadding = screenHeight * 0.02;
    double tabBorderRadius = screenHeight * 0.03;
    double buttonMargin =
        screenWidth * 0.015; // Adjust this for responsive margin

    return Scaffold(
      body: screens[myIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: Container(
          color: Colors.transparent,
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 89, 161, 91),
            selectedIndex: myIndex,
            color: Colors.white38,
            activeColor: Colors.green.shade500,
            tabBackgroundColor: Colors.white,
            tabBorderRadius: tabBorderRadius,
            tabActiveBorder: Border.all(color: Colors.grey),
            padding: EdgeInsets.symmetric(
              vertical: tabPadding,
              horizontal: screenWidth * 0.04,
            ),

            gap: screenWidth * 0.02, // space between icon and text
            onTabChange: (index) {
              setState(() {
                myIndex = index;
              });
            },
            tabs: [
              GButton(
                margin: EdgeInsets.all(buttonMargin),
                icon: FontAwesomeIcons.user,
                iconSize: iconSize,
                text: ' حسابي',
                textStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: fontSize,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GButton(
                margin: EdgeInsets.all(buttonMargin),
                icon: FontAwesomeIcons.cartShopping,
                iconSize: iconSize,
                text: ' سله التسوق',
                textStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: fontSize,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GButton(
                margin: EdgeInsets.all(buttonMargin),
                icon: Icons.grid_view_rounded,
                iconSize: iconSize,
                text: ' المنتجات',
                textStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: fontSize,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GButton(
                margin: EdgeInsets.all(buttonMargin),
                icon: FontAwesomeIcons.house,
                iconSize: iconSize,
                text: ' الرئيسيه',
                textStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: fontSize,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
