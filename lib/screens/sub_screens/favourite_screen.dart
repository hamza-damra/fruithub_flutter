import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/favourite_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/most_selling_product_card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  Future<List<Product>> getProducts() async {
    return await FavouriteManagement().getFavourites(
      token: await SharedPrefManager().getData('token'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('المفضله'),
        centerTitle: true,
      ),
      body: Expanded(
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
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/noProducts.png',
                      width: screenHeight * 0.5,
                      height: screenHeight * 0.25,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'لم يتم اضافه منتجات في المفضله',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final products = snapshot.data!;
              return Row(
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
                            screen: 'fav',
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
