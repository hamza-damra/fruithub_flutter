import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/products_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/screens/sub_screens/most_selling_screen.dart';
import 'package:fruitshub/widgets/most_selling_product_card.dart';

class MostSellingBuilder extends StatefulWidget {
  const MostSellingBuilder({
    super.key,
    required this.sortDirection,
    required this.showText,
  });

  final String sortDirection;
  final bool showText;

  @override
  State<MostSellingBuilder> createState() => _MostSellingBuilderState();
}

class _MostSellingBuilderState extends State<MostSellingBuilder> {
  Future<List<Product>> getProducts() async {
    return await ProductsManagement().getAllProducts(
      token: await SharedPrefManager().getData('token'),
      pageSize: '10',
      pageNumber: '0',
      sortDirection: widget.sortDirection,
      sortBy: 'orderCount',
    );
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
              future: getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitThreeBounce(
                    color: Colors.green,
                    size: 50.0,
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error.toString());
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
                    child: Text(
                      'No products available',
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
