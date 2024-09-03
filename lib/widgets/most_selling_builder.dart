import 'package:flutter/material.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/screens/sub_screens/details_screen.dart';
import 'package:fruitshub/screens/sub_screens/most_selling_screen.dart';
import 'package:fruitshub/widgets/most_selling_product_card.dart';

class MostSelling extends StatefulWidget {
  const MostSelling({
    super.key,
    required this.products,
    this.sorting,
    required this.showText,
  });

  final List<Product> products;
  final String? sorting;
  final bool showText;

  @override
  State<MostSelling> createState() => _MostSellingState();
}

class _MostSellingState extends State<MostSelling> {
  @override
  Widget build(BuildContext context) {
    if (widget.sorting == 'asc') {
      widget.products.sort((a, b) => a.price.compareTo(b.price));
    } else if (widget.sorting == 'desc') {
      widget.products.sort((a, b) => b.price.compareTo(a.price));
    } else {
      widget.products.sort((a, b) => a.name.compareTo(b.name));
    }
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Column(
        children: [
          widget.showText == true
              ? Padding(
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
                              return MostSellingScreen(
                                mostSellingProducts: mostSellingProducts,
                              );
                            },
                          ));
                        },
                        child: Text(
                          'المزيد',
                          style: TextStyle(
                            color: const Color(0xff949D9E),
                            fontWeight: FontWeight.w500,
                            fontSize: (MediaQuery.of(context).size.width *
                                        0.04 +
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
                )
              : const SizedBox(),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: widget.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2.5,
                      mainAxisSpacing: 8,
                      crossAxisSpacing:
                          MediaQuery.of(context).size.width * 0.04,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                product: widget.products[index],
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          screenWidth: MediaQuery.of(context).size.width,
                          screenHeight: MediaQuery.of(context).size.height,
                          product: widget.products[index],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
