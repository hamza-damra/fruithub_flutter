import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/products_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/screens/sub_screens/most_selling_screen.dart';
import 'package:fruitshub/widgets/most_selling_product_card.dart';
import 'package:http/http.dart' as http;

class MostSellingBuilder extends StatefulWidget {
  const MostSellingBuilder({
    super.key,
    required this.sortDirection,
    required this.sortBy,
    required this.showText,
  });

  final String sortDirection;
  final String sortBy;
  final bool showText;

  @override
  State<MostSellingBuilder> createState() => _MostSellingBuilderState();
}

class _MostSellingBuilderState extends State<MostSellingBuilder> {
  final scrollController = ScrollController();
  int totalItems = 0;

  Future<http.Response> getProducts() async {
    return await ProductsManagement().getAllProducts(
      token: await SharedPrefManager().getData('token'),
      itemsPerPage: '10',
      pageNumber: mostSellingPageNumber.toString(),
      sortDirection: widget.sortBy == 'name' ? 'desc' : widget.sortDirection,
      sortBy: widget.sortBy,
    );
  }

  Future<List<Product>> requestData() async {
    if (mostSelling.isEmpty) {
      final response = await getProducts();
      final Map<String, dynamic> data = jsonDecode(response.body);
      totalItems = data['totalItems'];
      mostSelling = data['items']
          .map<Product>(
            (json) => Product.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    }
    return mostSelling;
  }

  Future fetchNewData() async {
    mostSellingPageNumber += 1;
    final response = await getProducts();
    final Map<String, dynamic> data = jsonDecode(response.body);
    totalItems = data['totalItems'];
    if (mostSelling.length < totalItems) {
      setState(() {
        mostSelling.addAll(data['items']
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
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchNewData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Column(
        children: [
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
                widget.showText
                    ? GestureDetector(
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
                            fontSize:
                                (screenWidth * 0.04 + screenHeight * 0.02) / 2,
                          ),
                        ),
                      )
                    : const SizedBox(),
                widget.showText
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'الأكثر مبيعًا',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.050,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Expanded(
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
                  return const Center(
                    child: Text('No products available'),
                  );
                } else {
                  final products = snapshot.data!;

                  return Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.04,
                            ),
                            Expanded(
                              child: GridView.builder(
                                controller: scrollController,
                                itemCount: products.length + 1,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 2.5,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: screenWidth * 0.04,
                                ),
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
                                      child: ProductCard(
                                        product: products[index],
                                      ),
                                    );
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.04,
                            ),
                          ],
                        ),
                      ),
                      mostSelling.length < totalItems // &&
                          // scrollController.position.pixels ==
                          //     scrollController.position.maxScrollExtent
                          ? const SpinKitThreeBounce(
                              color: Colors.green,
                              size: 50.0,
                            )
                          : const SizedBox(),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
