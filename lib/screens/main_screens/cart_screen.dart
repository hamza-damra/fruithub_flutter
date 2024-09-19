import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruitshub/models/product.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    setState(() {
      totalPrice = widget.products.fold(
        0.0,
        (sum, product) => sum + (product.price) * (product.userQuantity),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'السله',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: widget.products.isNotEmpty
          ? ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xffF1F1F5),
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.09,
                      color: const Color(0xffEBF9F1),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'منتجات في سله التسوق',
                              style: TextStyle(
                                color: const Color(0xff1B5E37),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.sizeOf(context).width * 0.04,
                              ),
                            ),
                            Text(
                              ' ${widget.products.length} ',
                              style: TextStyle(
                                color: const Color(0xff1B5E37),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.sizeOf(context).width * 0.04,
                              ),
                            ),
                            Text(
                              'لديك',
                              style: TextStyle(
                                color: const Color(0xff1B5E37),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.sizeOf(context).width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) {
                        final product = widget.products[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenHeight * 0.01),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: SvgPicture.asset(
                                            'assets/images/trash.svg',
                                            width: screenWidth * 0.07,
                                            height: screenWidth * 0.07,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget.products.removeAt(index);
                                              _calculateTotalPrice(); // Recalculate total price after removal
                                            });
                                          },
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenHeight * 0.025,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'كجم',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xffF4A91F),
                                                    fontSize:
                                                        screenHeight * 0.02,
                                                  ),
                                                ),
                                                Text(
                                                  ' ${product.userQuantity}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xffF4A91F),
                                                    fontSize:
                                                        screenHeight * 0.02,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'جنيه ',
                                              style: TextStyle(
                                                color: const Color(0xffF4A91F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenHeight * 0.025,
                                              ),
                                            ),
                                            Text(
                                              (product.price *
                                                      product.userQuantity)
                                                  .toString(),
                                              style: TextStyle(
                                                color: const Color(0xffF4A91F),
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenHeight * 0.025,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (product.userQuantity > 1) {
                                                  setState(() {
                                                    product.userQuantity--;
                                                    _calculateTotalPrice(); // Recalculate total price when quantity is changed
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: screenWidth * 0.08,
                                                height: screenWidth * 0.08,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xffF3F5F7),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: Container(
                                                      height:
                                                          screenHeight * 0.003,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: screenWidth * 0.04),
                                            Text(
                                              product.userQuantity.toString(),
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.045,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: screenWidth * 0.04),
                                            GestureDetector(
                                              onTap: () {
                                                if (product.userQuantity <
                                                    product.stockQuantity) {
                                                  setState(() {
                                                    product.userQuantity++;
                                                    _calculateTotalPrice(); // Recalculate total price when quantity is changed
                                                  });
                                                } else {
                                                  showTopSnackBar(
                                                    Overlay.of(context),
                                                    const CustomSnackBar.info(
                                                      message:
                                                          "لا يمكنك تجاوز الكميه المتوفره للمنتج",
                                                      textAlign:
                                                          TextAlign.center,
                                                      textStyle: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: screenWidth * 0.08,
                                                height: screenWidth * 0.08,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xff1B5E37),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: screenWidth * 0.05,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: const Color(0xffF1F1F5),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Container(
                                width: screenWidth * 0.25,
                                height: screenHeight * 0.1,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF3F5F7),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      product.imageUrl,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                widget.products.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color(0xff1B5E37),
                              ),
                            ),
                            onPressed: () {
                              // Add payment handling logic here
                            },
                            child: Text(
                              'الدفع $totalPrice جنيه',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 16),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Responsive Image
                  Image.asset(
                    'assets/images/noCart.PNG',
                    width: screenHeight *
                        0.5, // Adjust width as 50% of screen width
                    height: screenHeight *
                        0.25, // Adjust height as 25% of screen height
                    fit: BoxFit
                        .contain, // Ensure image fits within the specified dimensions
                  ),

                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.02), // Responsive height

                  // Responsive Text
                  Text(
                    '! السله فارغه',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width *
                          0.05, // Adjust font size based on screen width
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
