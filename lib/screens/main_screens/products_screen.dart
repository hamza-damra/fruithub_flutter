import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruitshub/screens/sub_screens/most_selling_screen.dart';
import 'package:fruitshub/widgets/most_selling.dart';
import 'package:fruitshub/widgets/search.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'المنتجات',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.050,
            ),
          ),
        ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.01), // Responsive spacing
          Search(
            textScaleFactor: textScaleFactor,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.10,
                  height: screenWidth * 0.10, // Square container for the arrow
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: screenWidth * 0.005,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/arrow.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'منتجاتنا',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.050,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01), // Spacing between elements
          SizedBox(
            height: screenHeight * 0.15, // 15% of screen height
            child: Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.02, // 2% of screen width
              ),
              child: ListView.builder(
                reverse: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.02), // Responsive left padding
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
                                child: Image.asset(
                                  'assets/images/strawberry.png',
                                  fit: BoxFit.contain,
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
                              child: Text(
                                'فرولة',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w700,
                                  fontSize: screenWidth * 0.048,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01), // Spacing between elements
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.03,
              right: screenWidth * 0.03,
              bottom: screenWidth * 0.03,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const MostSellingScreen();
                      },
                    ));
                  },
                  child: Text(
                    'المزيد',
                    style: TextStyle(
                      color: const Color(0xff949D9E),
                      fontWeight: FontWeight.w500,
                      fontSize: (MediaQuery.of(context).size.width * 0.04 +
                              MediaQuery.of(context).size.height * 0.02) /
                          2,
                      // Responsive font size calculated as an average of width and height percentages
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'الأكثر مبيعًا',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth * 0.050,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01), // Spacing between elements
          MostSelling(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }
}
