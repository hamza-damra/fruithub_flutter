import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/cart_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/globals.dart';
import 'package:fruitshub/models/cartItem.dart';
import 'package:fruitshub/widgets/cart_item.dart';

class Cart extends StatefulWidget {
  const Cart({
    super.key,
  });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<List<Cartitem>> getProducts() async {
    return await CartManagement().getCartItems(
      token: await SharedPrefManager().getData('token'),
    );
  }

  Future<List<Cartitem>> requestData() async {
    if (cart.isEmpty) {
      cart = await getProducts();
      return cart;
    } else {
      return cart;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
      body: Stack(
        children: [
          // FutureBuilder to load cart items
          FutureBuilder(
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
              } else {
                List<Cartitem> items = snapshot.data ?? [];
                return Column(
                  children: [
                    // Fixed header text at the top
                    Container(
                      width: double.infinity,
                      height: screenHeight * 0.09,
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
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            Text(
                              ' ${items.length} ',
                              style: TextStyle(
                                color: const Color(0xff1B5E37),
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            Text(
                              'لديك',
                              style: TextStyle(
                                color: const Color(0xff1B5E37),
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: screenHeight * 0.1, // Space for the button
                        ),
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return CartItemWidget(
                              product: items[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          // Fixed pay button at the bottom with an icon
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1B5E37), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(Icons.payment, color: Colors.white), // Payment icon
                onPressed: () {
                  // Handle the payment action here
                },
                label: const Text(
                  'الدفع',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
