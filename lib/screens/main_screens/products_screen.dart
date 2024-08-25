import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/screens/sub_screens/most_selling_screen.dart';
import 'package:fruitshub/widgets/most_selling_builder.dart';
import 'package:fruitshub/widgets/our_product_card.dart';
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
    List<Product> products = [
      Product(
        id: 1,
        name: 'فواكه',
        description: 'fruits description',
        price: 30,
        quantity: 1,
        imageUrl:
            'https://www.fruitsmith.com/pub/media/mageplaza/blog/post/s/e/seedless_fruits.jpg',
        categoryId: 2,
        totalRating: 3.5,
        counterFiveStars: 3,
        counterFourStars: 6,
        counterThreeStars: 7,
        counterTwoStars: 3,
        counterOneStars: 2,
      ),
      Product(
        id: 1,
        name: 'سلطه فواكه',
        description: 'fruit salad description',
        price: 30,
        quantity: 1,
        imageUrl:
            'https://images.healthshots.com/healthshots/en/uploads/2022/04/17151621/fruit-salad.jpg',
        categoryId: 2,
        totalRating: 3.5,
        counterFiveStars: 3,
        counterFourStars: 6,
        counterThreeStars: 7,
        counterTwoStars: 3,
        counterOneStars: 2,
      ),
      Product(
        id: 1,
        name: 'مانجا',
        description: 'mango description',
        price: 30,
        quantity: 1,
        imageUrl:
            'https://hips.hearstapps.com/hmg-prod/images/mango-fruit-sugar-1530136260.jpg?crop=1xw:1xh;center,top&resize=640:*',
        categoryId: 2,
        totalRating: 3.5,
        counterFiveStars: 3,
        counterFourStars: 6,
        counterThreeStars: 7,
        counterTwoStars: 3,
        counterOneStars: 2,
      ),
      Product(
        id: 1,
        name: 'كريز',
        description: 'Cherries description',
        price: 30,
        quantity: 1,
        imageUrl:
            'https://hips.hearstapps.com/hmg-prod/images/cherries-sugar-fruit-1530136329.jpg?crop=1xw:1xh;center,top&resize=640:*',
        categoryId: 2,
        totalRating: 3.5,
        counterFiveStars: 3,
        counterFourStars: 6,
        counterThreeStars: 7,
        counterTwoStars: 3,
        counterOneStars: 2,
      ),
    ];

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
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.abc),
                    ],
                  );
                },
              );
            },
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
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DetailsScreen(
                            product: products[index],
                          );
                        },
                      ));
                    },
                    child: OurProductCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      product: products[index],
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
