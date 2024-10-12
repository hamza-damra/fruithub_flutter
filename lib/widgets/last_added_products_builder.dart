import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/products_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:http/http.dart' as http;

import '../screens/sub_screens/details_screen.dart';
import 'last_added_product_card.dart';

class LastAddedProducts extends StatefulWidget {
  const LastAddedProducts({super.key});

  @override
  State<LastAddedProducts> createState() => _LastAddedProductsState();
}

class _LastAddedProductsState extends State<LastAddedProducts> {
  final scrollController = ScrollController();
  int totalItems = 0;
  bool isLoading = false;
  bool allItemsLoaded = false;

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
              (json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return lastAdded;
  }

  Future fetchNewData() async {
    if (!isLoading && !allItemsLoaded) {
      setState(() {
        isLoading = true;
      });

      lastAddedPageNumber += 1;
      final response = await getProducts();
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (lastAdded.length < totalItems) {
        setState(() {
          lastAdded.addAll(data['items']
              .map<Product>(
                  (json) => Product.fromJson(json as Map<String, dynamic>))
              .toList());
        });
      } else {
        allItemsLoaded = true;
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchNewData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.15,
      child: Padding(
        padding: EdgeInsets.only(
          right: screenWidth * 0.02,
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
              return const Center(
                child: Text('Error loading products'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products available'));
            } else {
              final products = snapshot.data!;
              return ListView.builder(
                controller: scrollController,
                reverse: true,
                itemCount: products.length + (isLoading ? 1 : 0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index < products.length) {
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
                      child: LastAddedProductCard(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        product: products[index],
                      ),
                    );
                  } else if (isLoading) {
                    return const Center(
                      child: SpinKitThreeBounce(
                        color: Colors.green,
                        size: 50.0,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
