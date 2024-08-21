import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  int myIndex = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const ProductsScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[myIndex],
      bottomNavigationBar: GNav(
        selectedIndex: myIndex,
        color: Colors.grey[400],
        activeColor: const Color(0xffEEEEEE),
        tabBackgroundColor: Colors.white,
        tabBorderRadius: 35,
        tabActiveBorder: Border.all(color: Colors.grey),
        onTabChange: (index) {
          setState(() {
            myIndex = index;
          });
        },
        tabs: const [
          GButton(
            icon: FontAwesomeIcons.user,
            text: ' حسابي',
            textStyle: TextStyle(
              fontFamily: 'Cairo',
              color: Color(0xff1B5E37),
            ),
          ),
          GButton(
            icon: FontAwesomeIcons.cartShopping,
            text: ' سله التسوق',
            textStyle: TextStyle(
              fontFamily: 'Cairo',
              color: Color(0xff1B5E37),
            ),
          ),
          GButton(
            icon: Icons.grid_view_rounded,
            text: ' المنتجات',
            textStyle: TextStyle(
              fontFamily: 'Cairo',
              color: Color(0xff1B5E37),
            ),
          ),
          GButton(
            icon: FontAwesomeIcons.house,
            text: ' الرئيسيه',
            textStyle: TextStyle(
              fontFamily: 'Cairo',
              color: Color(0xff1B5E37),
            ),
          ),
        ],
      ),
    );
  }
}
