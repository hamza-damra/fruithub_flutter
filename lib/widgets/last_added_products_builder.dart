import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/products_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/last_added_product_card.dart';

class LastAddedProducts extends StatelessWidget {
  const LastAddedProducts({super.key});

  Future<List<Product>> getProducts() async {
    return await ProductsManagement().getAllProducts(
      token: await SharedPrefManager().getData('token'),
      pageSize: '10',
      pageNumber: '0',
      sortDirection: 'desc',
      sortBy: 'createdAt',
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.15, // 15% of screen height
      child: Padding(
        padding: EdgeInsets.only(
          right: screenWidth * 0.02, // 2% of screen width
        ),
        child: FutureBuilder<List<Product>>(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitThreeBounce(
                color: Colors.green,
                size: 50.0,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/error.png',
                      width: screenHeight * 0.1,
                      height: screenHeight * 0.10,
                      fit: BoxFit.contain,
                    ),
                    // SizedBox(height: screenHeight * 0.03),
                    Text(
                      '! حدث خطا اثناء تحميل البيانات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.03,
                      ),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available'));
            } else {
              final products = snapshot.data!;
              return ListView.builder(
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
                    child: LastAddedProductCard(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      product: products[index],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
