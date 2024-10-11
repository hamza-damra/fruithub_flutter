import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/products_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/last_added_product_card.dart';
import 'package:http/http.dart' as http;

class LastAddedProducts extends StatefulWidget {
  const LastAddedProducts({super.key});

  @override
  State<LastAddedProducts> createState() => _LastAddedProductsState();
}

class _LastAddedProductsState extends State<LastAddedProducts> {
  final scrollController = ScrollController();
  int totalItems = 0;
  Future<http.Response> getProducts() async {
    return await ProductsManagement().getAllProducts(
      token: await SharedPrefManager().getData('token'),
      itemsPerPage: '10',
      pageNumber: lastAddedPageNumber.toString(),
      sortDirection: 'desc',
      sortBy: 'createdAt',
    );
  }

  Future<List<Product>> requestData() async {
    if (lastAdded.isEmpty) {
      final response = await getProducts();
      final Map<String, dynamic> data = jsonDecode(response.body);
      totalItems = data['totalItems'];

      lastAdded = data['items']
          .map<Product>(
            (json) => Product.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    }
    return lastAdded;
  }

  Future fetchNewData() async {
    lastAddedPageNumber += 1;
    final response = await getProducts();
    final Map<String, dynamic> data = jsonDecode(response.body);
    totalItems = data['totalItems'];
    if (lastAdded.length < totalItems) {
      setState(() {
        lastAdded.addAll(data['items']
            .map<Product>(
                (json) => Product.fromJson(json as Map<String, dynamic>))
            .toList());
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose(); // Disposing the controller
    super.dispose();
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
          future: requestData(),
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
                controller: scrollController,
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
