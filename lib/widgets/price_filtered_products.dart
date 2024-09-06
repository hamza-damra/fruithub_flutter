import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/most_selling_product_card.dart';

import '../bloc/cubit/filter_products_cubit.dart';

class PriceFilteredProducts extends StatefulWidget {
  const PriceFilteredProducts({
    super.key,
    required this.start,
    required this.end,
    required this.products,
  });

  final int start;
  final int end;
  final List<Product> products;

  @override
  State<PriceFilteredProducts> createState() => _PriceFilteredProductsState();
}

class _PriceFilteredProductsState extends State<PriceFilteredProducts> {
  late List<Product> filteredProducts;

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products.where((product) {
      return product.price >= widget.start && product.price <= widget.end;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<ProductsCubit>().loadProducts(sortingOrder: 'most');
                        minNum = 0;
                        maxNum = 0;
                        start.clear();
                        end.clear();
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'نتائج ',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.050,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        filteredProducts.length.toString(),
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.050,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.04,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
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
                                product: filteredProducts[index],
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          screenWidth: screenWidth,
                          screenHeight: MediaQuery.of(context).size.height,
                          product: filteredProducts[index],
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
          ),
        ],
      ),
    );
  }
}
