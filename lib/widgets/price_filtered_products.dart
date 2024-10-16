import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/products_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/bloc/filter_products_cubit.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/widgets/most_selling_product_card.dart';

class PriceFilteredProducts extends StatefulWidget {
  const PriceFilteredProducts({
    super.key,
    required this.max,
    required this.min,
  });

  final double max;
  final double min;

  @override
  State<PriceFilteredProducts> createState() => _PriceFilteredProductsState();
}

class _PriceFilteredProductsState extends State<PriceFilteredProducts> {
  Future<List<Product>> getFilteredProducts() async {
    return await ProductsManagement().getFilteredProducts(
      token: await SharedPrefManager().getData('token'),
      min: widget.min,
      max: widget.max,
    );
  }

  @override
  void initState() {
    getFilteredProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: Column(
        children: [
          // The row will be displayed once the products are fetched
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: getFilteredProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
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
                            const SizedBox(),
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
                            )
                          ],
                        ),
                      ),
                      const Expanded(
                        child: SpinKitThreeBounce(
                          color: Colors.green,
                          size: 50.0,
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
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
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
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
                                    context
                                        .read<ProductsCubit>()
                                        .showProductState(
                                          myState: 'most',
                                        );
                                    minNum = 0;
                                    maxNum = 0;
                                    maxController.clear();
                                    minController.clear();
                                    mostSelling = [];
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                  ),
                                ),
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
                                    '0',
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
                      Column(
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
                    ],
                  );
                } else {
                  final products = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
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
                                    context
                                        .read<ProductsCubit>()
                                        .showProductState(myState: 'most');
                                    minNum = 0;
                                    maxNum = 0;
                                    maxController.clear();
                                    minController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                  ),
                                ),
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
                                    '${products.length}',
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
                                itemCount: products.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
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
                      ),
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
