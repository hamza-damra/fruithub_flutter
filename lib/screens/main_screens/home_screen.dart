import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruitshub/widgets/most_selling.dart';
import 'package:fruitshub/widgets/product_card.dart';
import 'package:fruitshub/widgets/search.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "سيتم توفير الاشعارات قريبا",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.cyan[100],
                  textColor: const Color.fromARGB(255, 129, 129, 129),
                  fontSize: 16.0,
                );
              },
              color: const Color.fromARGB(255, 39, 139, 43),
              iconSize: screenWidth * 0.07,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.01), // Responsive spacing
          Search(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            textScaleFactor: textScaleFactor,
          ),
          const SizedBox(height: 7),
          MostSelling(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }
}
