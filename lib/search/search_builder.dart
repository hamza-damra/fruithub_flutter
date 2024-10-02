import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/search_management.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/most_selling_product_card.dart';

class SearchBuilder extends StatelessWidget {
  const SearchBuilder({
    super.key,
    required this.token,
    required this.query,
  });
  final String token;
  final String query;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: SearchManagement().searchProducts(token: token, product: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: SpinKitThreeBounce(
                color: Colors.green,
                size: 50.0,
              ),
            );
          }

          // Error state
          if (snapshot.hasError) {
            print(snapshot.error);
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/error.png',
                      width: screenHeight * 0.5,
                      height: screenHeight * 0.25,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      '! حدث خطا اثناء تحميل البيانات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Success state
          if (snapshot.hasData) {
            final products = snapshot.data;

            if (products == null || products.isEmpty) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/noResult.png',
                        width: screenHeight * 0.5,
                        height: screenHeight * 0.25,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        'لا يوجد منتجات متطابقه مع بحثك',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Scaffold(
              backgroundColor: Colors.white,
              body: Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 2.5,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: screenWidth * 0.04,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  product: products[index],
                                ),
                              ),
                            );
                          },
                          child: ProductCard(
                            product: products[index],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                ],
              ),
            );
          }

          // No data found
          return const Center(
            child: Text(
              'لا توجد بيانات',
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
